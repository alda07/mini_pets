//
//  AHCell.swift
//  Bookiie
//
//  Created by HanhVo on 5/15/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class AHBookedCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDateTime: UILabel!
    @IBOutlet weak var lbNumberOfPeople: UILabel!
    @IBOutlet weak var lbBookedAt: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // for bgView
        bgView.layer.cornerRadius = 4.0
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = GreenTheme.CGColor
        
    }
    
}
