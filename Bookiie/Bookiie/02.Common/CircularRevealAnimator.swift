//
//  CircularRevealAnimator.swift
//  Bookiie
//
//  Created by HanhVo on 5/13/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import QuartzCore

private func SquareAroundCircle(center: CGPoint, radius: CGFloat) -> CGRect {
    assert(0 <= radius, "radius must be a positive value")
    return CGRectInset(CGRect(origin: center, size: CGSizeZero), -radius, -radius)
}

class CircularRevealAnimator {
    var completion: () -> Void = {}
    
    private let layer: CALayer
    private let mask: CAShapeLayer
    private let animation: CABasicAnimation
    
    var duration: CFTimeInterval {
        get { return animation.duration }
        set(value) { animation.duration = value }
    }
    
    var timingFunction: CAMediaTimingFunction! {
        get { return animation.timingFunction }
        set(value) { animation.timingFunction = value }
    }
    
    init(layer: CALayer, center: CGPoint, startRadius: CGFloat, endRadius: CGFloat) {
        let startPath = CGPathCreateWithEllipseInRect(SquareAroundCircle(center, radius: startRadius), nil)
        let endPath = CGPathCreateWithEllipseInRect(SquareAroundCircle(center, radius: endRadius), nil)
        
        self.layer = layer
        
        mask = CAShapeLayer()
        mask.path = endPath
        
        animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath
        animation.toValue = endPath
        animation.delegate = AnimationDelegate {
            layer.mask = nil
            self.completion()
            self.animation.delegate = nil
        }
    }
    
    func start() {
        layer.mask = mask
        mask.frame = layer.bounds
        mask.addAnimation(animation, forKey: "reveal")
    }
}