import UIKit


@warn_unused_result
func Init<Type>(value: Type, @noescape block: (object: Type) -> Void) -> Type {
    block(object: value)
    return value
}

@objc public protocol MenuDelegate {
    
    optional func menu(menu: Menu, willDisplay button: UIButton, atIndex: Int)
    optional func menu(menu: Menu, buttonWillSelected button: UIButton, atIndex: Int)
    optional func menu(menu: Menu, buttonDidSelected button: UIButton, atIndex: Int)
}

public class Menu: UIButton {
    
    // MARK: properties
    @IBInspectable public var buttonsCount: Int = 3
    @IBInspectable public var duration: Double  = 2
    @IBInspectable public var distance: Float   = 100
    @IBInspectable public var showDelay: Double = 0
    @IBOutlet weak public var delegate: AnyObject?
    
    var buttons: [UIButton]?
    
    private var customNormalIconView: UIImageView!
    private var customSelectedIconView: UIImageView!
    
    // MARK: life cycle
    public init(frame: CGRect, normalIcon: String?, selectedIcon: String?, buttonsCount: Int = 3, duration: Double = 2,
                distance: Float = 100) {
        super.init(frame: frame)
        
        if let icon = normalIcon {
            setImage(UIImage(named: icon), forState: .Normal)
        }
        
        if let icon = selectedIcon {
            setImage(UIImage(named: icon), forState: .Selected)
        }
        
        self.buttonsCount = buttonsCount
        self.duration     = duration
        self.distance     = distance
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        addActions()
        
        customNormalIconView = addCustomImageView(state: .Normal)
        
        customSelectedIconView = addCustomImageView(state: .Selected)
        if customSelectedIconView != nil {
            customSelectedIconView.alpha = 0
        }
        setImage(UIImage(), forState: .Normal)
        setImage(UIImage(), forState: .Selected)
    }
   
    public func hideButtons(duration: Double, hideDelay: Double = 0) {
        if buttons == nil {
            return
        }
        
        buttonsAnimationIsShow(isShow: false, duration: duration, hideDelay: hideDelay)
        
        tapBounceAnimation()
        tapRotatedAnimation(0.3, isSelected: false)
    }
    
    public func buttonsIsShown() -> Bool {
        guard let buttons = self.buttons else {
            return false
        }
        
        for button in buttons {
            if button.alpha == 0 {
                return false
            }
        }
        return true
    }
    
    private func createButtons() -> [UIButton] {
        var buttons = [UIButton]()
        
        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {
            
            let angle: Float = Float(index) * step
            let distance = Float(self.bounds.size.height/2.0)
            let button = Init(MenuButton(size: self.bounds.size, circleMenu: self, distance:distance, angle: angle)) {
                $0.tag = index
                $0.addTarget(self, action: #selector(Menu.buttonHandler(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                $0.alpha = 0
            }
            buttons.append(button)
        }
        return buttons
    }
    
    private func addCustomImageView(state state: UIControlState) -> UIImageView? {
        guard let image = imageForState(state) else {
            return nil
        }
        
        let iconView = Init(UIImageView(image: image)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode                               = .Center
            $0.userInteractionEnabled                    = false
        }
        addSubview(iconView)
        
        // added constraints
        iconView.addConstraint(NSLayoutConstraint(item: iconView, attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: .Height, multiplier: 1, constant: bounds.size.height))
        
        iconView.addConstraint(NSLayoutConstraint(item: iconView, attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: .Width, multiplier: 1, constant: bounds.size.width))
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: iconView,
            attribute: .CenterX, multiplier: 1, constant:0))
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal, toItem: iconView,
            attribute: .CenterY, multiplier: 1, constant:0))
        
        return iconView
    }
    
    // MARK: configure
    
    private func addActions() {
        self.addTarget(self, action: #selector(Menu.onTap), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: actions
    func onTap() {
        if buttonsIsShown() == false {
            buttons = createButtons()
        }
        let isShow = !buttonsIsShown()
        let duration  = isShow ? 0.5 : 0.2
        buttonsAnimationIsShow(isShow: isShow, duration: duration)
        
        tapBounceAnimation()
        tapRotatedAnimation(0.3, isSelected: isShow)
    }
    
    func buttonHandler(sender: UIButton) {
        guard case let sender as MenuButton = sender else {
            return
        }
        
        delegate?.menu?(self, buttonWillSelected: sender, atIndex: sender.tag)
        
        let circle = MenuLoader(radius: CGFloat(distance), strokeWidth: bounds.size.height, circleMenu: self,
                                      color: sender.backgroundColor)
        
        if let container = sender.container { // rotation animation
            sender.rotationLayerAnimation(container.angleZ + 360, duration: duration)
            container.superview?.bringSubviewToFront(container)
        }
        
        if let aButtons = buttons {
            circle.fillAnimation(duration, startAngle: -90 + Float(360 / aButtons.count) * Float(sender.tag))
            circle.hideAnimation(0.5, delay: duration)
            
            hideCenterButton(duration: 0.3)
            
            buttonsAnimationIsShow(isShow: false, duration: 0, hideDelay: duration)
            showCenterButton(duration: 0.525, delay: duration)
            
            if customNormalIconView != nil && customSelectedIconView != nil {
                let dispatchTime: dispatch_time_t = dispatch_time(
                    DISPATCH_TIME_NOW,
                    Int64(duration * Double(NSEC_PER_SEC)))
                
                dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                    self.delegate?.menu?(self, buttonDidSelected: sender, atIndex: sender.tag)
                })
            }
        }
    }
    
    // MARK: animations
    
    private func buttonsAnimationIsShow(isShow isShow: Bool, duration: Double, hideDelay: Double = 0) {
        guard let buttons = self.buttons else {
            return
        }
        
        let step: Float = 360.0 / Float(self.buttonsCount)
        for index in 0..<self.buttonsCount {
            guard case let button as MenuButton = buttons[index] else { continue }
            let angle: Float = Float(index) * step
            if isShow == true {
                delegate?.menu?(self, willDisplay: button, atIndex: index)
                
                button.rotatedZ(angle: angle, animated: false, delay: Double(index) * showDelay)
                button.showAnimation(distance: distance, duration: duration, delay: Double(index) * showDelay)
            } else {
                button.hideAnimation(
                    distance: Float(self.bounds.size.height / 2.0),
                    duration: duration, delay: hideDelay)
            }
        }
        if isShow == false { // hide buttons and remove
            self.buttons = nil
        }
    }
    
    private func tapBounceAnimation() {
        self.transform = CGAffineTransformMakeScale(0.9, 0.9)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5,
                                   options: UIViewAnimationOptions.CurveLinear,
                                   animations: { () -> Void in
                                    self.transform = CGAffineTransformMakeScale(1, 1)
            },
                                   completion: nil)
    }
    
    private func tapRotatedAnimation(duration: Float, isSelected: Bool) {
        
        let addAnimations: (view: UIImageView, isShow: Bool) -> () = { (view, isShow) in
            var toAngle: Float   = 180.0
            var fromAngle: Float = 0
            var fromScale        = 1.0
            var toScale          = 0.2
            var fromOpacity      = 1
            var toOpacity        = 0
            if isShow == true {
                toAngle     = 0
                fromAngle   = -180
                fromScale   = 0.2
                toScale     = 1.0
                fromOpacity = 0
                toOpacity   = 1
            }
            
            let rotation = Init(CABasicAnimation(keyPath: "transform.rotation")) {
                $0.duration       = NSTimeInterval(duration)
                $0.toValue        = (toAngle.degrees)
                $0.fromValue      = (fromAngle.degrees)
                $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            }
            let fade = Init(CABasicAnimation(keyPath: "opacity")) {
                $0.duration            = NSTimeInterval(duration)
                $0.fromValue           = fromOpacity
                $0.toValue             = toOpacity
                $0.timingFunction      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                $0.fillMode            = kCAFillModeForwards
                $0.removedOnCompletion = false
            }
            let scale = Init(CABasicAnimation(keyPath: "transform.scale")) {
                $0.duration       = NSTimeInterval(duration)
                $0.toValue        = toScale
                $0.fromValue      = fromScale
                $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            }
            
            view.layer.addAnimation(rotation, forKey: nil)
            view.layer.addAnimation(fade, forKey: nil)
            view.layer.addAnimation(scale, forKey: nil)
        }
        
        if customNormalIconView != nil && customSelectedIconView != nil {
            addAnimations(view: customNormalIconView, isShow: !isSelected)
            addAnimations(view: customSelectedIconView, isShow: isSelected)
        }
        selected = isSelected
        self.alpha = isSelected ? 0.3 : 1
    }
    
    private func hideCenterButton(duration duration: Double, delay: Double = 0) {
        UIView.animateWithDuration( NSTimeInterval(duration), delay: NSTimeInterval(delay),
                                    options: UIViewAnimationOptions.CurveEaseOut,
                                    animations: { () -> Void in
                                        self.transform = CGAffineTransformMakeScale(0.001, 0.001)
            }, completion: nil)
    }
    
    private func showCenterButton(duration duration: Float, delay: Double) {
        UIView.animateWithDuration( NSTimeInterval(duration), delay: NSTimeInterval(delay), usingSpringWithDamping: 0.78,
                                    initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear,
                                    animations: { () -> Void in
                                        self.transform = CGAffineTransformMakeScale(1, 1)
                                        self.alpha     = 1
            },
                                    completion: nil)
        
        let rotation = Init(CASpringAnimation(keyPath: "transform.rotation")) {
            $0.duration        = NSTimeInterval(1.5)
            $0.toValue         = (0)
            $0.fromValue       = (Float(-180).degrees)
            $0.damping         = 10
            $0.initialVelocity = 0
            $0.beginTime       = CACurrentMediaTime() + delay
        }
        let fade = Init(CABasicAnimation(keyPath: "opacity")) {
            $0.duration            = NSTimeInterval(0.01)
            $0.toValue             = 0
            $0.timingFunction      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            $0.fillMode            = kCAFillModeForwards
            $0.removedOnCompletion = false
            $0.beginTime           = CACurrentMediaTime() + delay
        }
        let show = Init(CABasicAnimation(keyPath: "opacity")) {
            $0.duration            = NSTimeInterval(duration)
            $0.toValue             = 1
            $0.timingFunction      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            $0.fillMode            = kCAFillModeForwards
            $0.removedOnCompletion = false
            $0.beginTime           = CACurrentMediaTime() + delay
        }
        
        if customNormalIconView != nil {
            customNormalIconView.layer.addAnimation(rotation, forKey: nil)
            customNormalIconView.layer.addAnimation(show, forKey: nil)
        }
        
        if customSelectedIconView != nil {
            customSelectedIconView.layer.addAnimation(fade, forKey: nil)
        }
    }
}



