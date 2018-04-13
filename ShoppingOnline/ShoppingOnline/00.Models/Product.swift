//
//  Product.swift
//  ShoppingOnline
//
//  Created by HanhVo on 7/10/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class Product: NSObject {
    
    var title: String?
    var listImage: ProductImage?
    var price: Float?
    
    var raiting: Float?
    var sizes: Array<String>?
    var brand: String?
    var colors : Array<String>?
    var id: String?
    var detailImages : Array<ProductImage>?
    
    init(jsonDictionary: NSDictionary) {
        
        super.init()
        
        //parse json
        id = String(format:"%d", ((jsonDictionary["id"] as? NSNumber)?.intValue)!)
        title = jsonDictionary["title"] as? String
        price = (jsonDictionary["price"] as? NSNumber)?.floatValue
        raiting = (jsonDictionary["raiting"] as? NSNumber)?.floatValue
        sizes = jsonDictionary["sizes"] as? Array<String>
        brand = jsonDictionary["brand"] as? String
        colors = jsonDictionary["colors"] as? Array<String>
        
        detailImages =  Array<ProductImage>()
        
        var tempImages = Array<NSDictionary>()
        tempImages = (jsonDictionary["images"] as? Array<NSDictionary>)!
        
        for  dic: NSDictionary in tempImages {
            
            let productImage = ProductImage.init(dic: dic)
            (productImage.type?.isEqualToString("list") == true) ? (self.listImage = productImage) : (self.detailImages?.append(productImage))
            
        }
    }
    
}
