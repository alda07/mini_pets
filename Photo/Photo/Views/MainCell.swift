//
//  MainCell.swift
//  Photo
//
//  Created by HanhVo on 8/2/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

import Alamofire

class MainCell: UICollectionViewCell
{
    //MARK:- UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewLayoutHeight: NSLayoutConstraint!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    //MARK:- Properties
    var request:Request?
    
    //MARK:- Methods
    func reset()
    {
        imageView.image = nil
        request?.cancel()
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes)
    {
        super.applyLayoutAttributes(layoutAttributes)
    }
}

