//
//  ImageTextField.swift
//  Bookiie
//
//  Created by HanhVo on 5/14/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setLeftIcon(imageName:String)  {
        
        leftView = UIImageView(image: UIImage(named:imageName))
        
        leftViewMode = .Always
    }
}

extension UITextField
{
    func drawBottomBorder(color:UIColor, width:Float)
    {
        self.borderStyle = UITextBorderStyle.None;
        let border = CALayer()
        let width = CGFloat(width)
        border.borderColor = color.CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
