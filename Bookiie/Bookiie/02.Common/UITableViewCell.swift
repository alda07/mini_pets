//
//  UITableViewCell.swift
//  Bookiie
//
//  Created by HanhVo on 5/13/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

extension UITableViewCell {
    @IBInspectable
    var normalBackgroundColor: UIColor? {
        get {
            return backgroundView?.backgroundColor
        }
        set(color) {
            let background = UIView()
            background.backgroundColor = color
            backgroundView = background
        }
    }
    
    @IBInspectable
    var selectedBackgroundColor: UIColor? {
        get {
            return selectedBackgroundView?.backgroundColor
        }
        set(color) {
            let background = UIView()
            background.backgroundColor = color
            selectedBackgroundView = background
        }
    }
}
