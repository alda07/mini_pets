//
//  ProductImageCell.swift
//  ShoppingOnline
//
//  Created by HanhVo on 7/11/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class ProductImageCell: UICollectionViewCell {
    
    //MARK: UI
    @IBOutlet weak var thumnailImage: UIImageView!
    
    //MARK: Methods
    func setContentForUI(productImage:ProductImage) {
        
        // view
        self.backgroundColor = UIColor.whiteColor()
        
        // load thumbnailImage
        thumnailImage.kf_setImageWithURL(NSURL(string:productImage.thumbnail as! String)!)
    }
    
}
