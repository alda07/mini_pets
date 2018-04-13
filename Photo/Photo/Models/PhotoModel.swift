//
//  PhotoModel.swift
//  Photo
//
//  Created by HanhVo on 8/2/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class ImageData
{
    //MARK: Properties
    let title:String
    let url:String
    let width:Int
    let height:Int
    
    //MARK: Methods
    init(title:String, url:String, width:Int, height:Int)
    {
        self.title = title
        self.url = url
        self.width = width
        self.height = height
    }
    
    func getSize() -> CGSize
    {
        return CGSize(width: width, height: height)
    }
}
