//
//  MenuLoader.swift
//  Husky
//
//  Created by HanhVo on 6/8/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import Foundation
import UIKit

internal class MenuLoader: UIView {
    
    // MARK: properties
    
    var circle: CAShapeLayer?
    
    // MARK: life cycle
    
    internal init(radius: CGFloat, strokeWidth: CGFloat, circleMenu: Menu, color: UIColor?) {
        super.init(frame: CGRect(x: 0, y: 0, width: radius, height: radius))
        
        if let aSuperView = circleMenu.superview {
            aSuperView.insertSubview(self, belowSubview: circleMenu)
        }
        
        circle = createCircle(radius, strokeWidth: strokeWidth, color: color)
        createConstraints(circleMenu, radius: radius)
        
        let circleFrame = CGRect(
            x: radius * 2 - strokeWidth,
            y: radius - strokeWidth / 2,
            width: strokeWidth,
            height: strokeWidth)
        createRoundView(circleFrame, color: color)
        
        backgroundColor = UIColor.clearColor()
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: create
    
    private func createCircle(radius: CGFloat, strokeWidth: CGFloat, color: UIColor?) -> CAShapeLayer {
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: radius, y: radius),
            radius: CGFloat(radius) - strokeWidth / 2.0,
            startAngle: CGFloat(0),
            endAngle:CGFloat(M_PI * 2),
            clockwise: true)
        
        let circle = Init(CAShapeLayer()) {
            $0.path        = circlePath.CGPath
            $0.fillColor   = UIColor.clearColor().CGColor
            $0.strokeColor = color?.CGColor
            $0.lineWidth   = strokeWidth
        }
        
        self.layer.addSublayer(circle)
        return circle
    }
    
    private func createConstraints(circleMenu: Menu, radius: CGFloat) {
        
        guard let circleMenuSuperView = circleMenu.superview else {
            fatalError()
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        // added constraints
        addConstraint(NSLayoutConstraint(item: self,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1,
            constant: radius * 2.0))
        
        addConstraint(NSLayoutConstraint(item: self,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Width,
            multiplier: 1,
            constant: radius * 2.0))
        
        circleMenuSuperView.addConstraint(NSLayoutConstraint(item: circleMenu,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterX,
            multiplier: 1,
            constant:0))
        
        circleMenuSuperView.addConstraint(NSLayoutConstraint(item: circleMenu,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1,
            constant:0))
    }
    
    internal func createRoundView(rect: CGRect, color: UIColor?) {
        let roundView = Init(UIView(frame: rect)) {
            $0.backgroundColor = UIColor.blackColor()
            $0.layer.cornerRadius = rect.size.width / 2.0
            $0.backgroundColor = color
        }
        addSubview(roundView)
    }
    
    // MARK: animations
    
    internal func fillAnimation(duration: Double, startAngle: Float) {
        guard circle != nil else {
            return
        }
        
        let rotateTransform = CATransform3DMakeRotation(CGFloat(startAngle.degrees), 0, 0, 1)
        layer.transform = rotateTransform
        
        let animation = Init(CABasicAnimation(keyPath: "strokeEnd")) {
            $0.duration       = CFTimeInterval(duration)
            $0.fromValue      = (0)
            $0.toValue        = (1)
            $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        }
        circle?.addAnimation(animation, forKey: nil)
    }
    
    internal func hideAnimation(duration: CGFloat, delay: Double) {
        
        let scale = Init(CABasicAnimation(keyPath: "transform.scale")) {
            $0.toValue             = 1.2
            $0.duration            = CFTimeInterval(duration)
            $0.fillMode            = kCAFillModeForwards
            $0.removedOnCompletion = false
            $0.timingFunction      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            $0.beginTime           = CACurrentMediaTime() + delay
        }
        layer.addAnimation(scale, forKey: nil)
        
        UIView.animateWithDuration(
            CFTimeInterval(duration),
            delay: delay,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.alpha = 0
            },
            completion: { (success) -> Void in
                self.removeFromSuperview()
        })
    }
}
