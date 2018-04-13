//
//  ProductImage.swift
//  ShoppingOnline
//
//  Created by HanhVo on 7/10/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class ProductImage: NSObject {
    
    var thumbnail: NSString?
    var type: NSString?
    var url: NSString?
    
    init(dic: NSDictionary) {
        
        thumbnail = dic["thumbnail"] as? String
        url = dic["url"] as? String
        type = dic["type"] as? String
    }

}

