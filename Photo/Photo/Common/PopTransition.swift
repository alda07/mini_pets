//
//  PopTransition.swift
//  Photo
//
//  Created by HanhVo on 8/2/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class PopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    //MARK: Properties
    let duration    = 1.0
    var presenting  = true
    var originFrame = CGRect.zero
    
    //MARK: Methods
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?)-> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let imageView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : imageView.frame
        let finalFrame = presenting ? imageView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            imageView.transform = scaleTransform
            imageView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            imageView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(imageView)
        
        UIView.animateWithDuration(duration, delay:0.0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    imageView.transform = self.presenting ?
                                        CGAffineTransformIdentity : scaleTransform
                                    
                                    imageView.center = CGPoint(x: CGRectGetMidX(finalFrame),
                                        y: CGRectGetMidY(finalFrame))
                                    
            }, completion:{_ in
                transitionContext.completeTransition(true)
        })
    }
    
}

