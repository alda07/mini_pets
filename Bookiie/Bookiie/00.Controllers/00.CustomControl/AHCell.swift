//
//  AHCell.swift
//  Bookiie
//
//  Created by HanhVo on 5/15/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class AHCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCuisine: UILabel!
    @IBOutlet weak var lbDistance: UILabel!
    @IBOutlet weak var ratinControl: UIView!
    @IBOutlet weak var discountLabel: UIImageView!
    
    var ratingView:AHRatingView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // for ratinControl
        ratingView = AHRatingView.fromNib()
        ratinControl.addSubview(ratingView!)
        
        // for bgView
        bgView.layer.cornerRadius = 4.0
        bgView.layer.borderWidth = 0.5
        bgView.layer.borderColor = GreenTheme.CGColor
        
    }
    
}
