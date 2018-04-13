//
//  UIImageView.swift
//  Bookiie
//
//  Created by HanhVo on 5/17/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func makeBlurImage()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
}