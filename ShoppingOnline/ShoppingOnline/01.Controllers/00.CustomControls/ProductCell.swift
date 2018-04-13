//
//  ProductCell.swift
//  ShoppingOnline
//
//  Created by HanhVo on 7/10/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

import Kingfisher

class ProductCell: UICollectionViewCell {
    
    //MARK: UI
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var thumnailImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var title: UILabel!
    
    //MARK: Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // configureUI
        configureUI()
    }
    
    //MARK: Methods
    func setContentForUI(product:Product) {
        
        // view
        self.backgroundColor = UIColor.whiteColor()
        
        // for price label
        price.text = String(format:"$ %.2f", product.price!)
        
        // for title label
        title.text = product.title
        // load thumbnailImage
        thumnailImage.kf_setImageWithURL(NSURL(string:product.listImage?.thumbnail as! String)!)
    }
    
    func configureUI()  {
        //for imageContentView
        imageContentView.backgroundColor = UIColor.whiteColor()
        imageContentView.layer.borderColor = UIColor.blackColor().CGColor
        imageContentView.layer.borderWidth = 0.5
        
        // for price
        price.backgroundColor = UIColor.clearColor()
        
        // for title
        title.backgroundColor = UIColor.clearColor()
    }
    
}
