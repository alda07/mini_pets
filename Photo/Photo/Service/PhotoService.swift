//
//  PhotoService.swift
//  Photo
//
//  Created by HanhVo on 8/2/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON

class PhotoService
{
    //MARK: Properties
    static let sharedInstance:PhotoService = PhotoService()
    var api_key:String?
    
    //MARK: Private Methods
    private init()
    {
        guard let path = NSBundle.mainBundle().pathForResource("APIKey", ofType: "plist") else
        {
            return
        }
        
        guard let dict = NSDictionary(contentsOfFile: path) else
        {
            return
        }
        
        api_key = dict["api_key"] as? String
    }
    
    //MARK: Public Methods
    func getPhotos(search_text:String, completionHandler:(photos:[ImageData]) -> Void)
    {
        let base_url = "https://api.flickr.com/services/rest/"
        let method_name = "flickr.photos.search"
        let extras = "url_m, o_dims"
        let data_format = "json"
        let search_text = search_text
        let no_json_callback = "1"
        let safe_search = "3"
        let results_per_page = "500"
        
        let parameters:[String : AnyObject] =
            [
                "method"        : method_name,
                "api_key"       : api_key!,
                "text"          : search_text,
                "extras"        : extras,
                "format"        : data_format,
                "nojsoncallback": no_json_callback,
                "per_page"      : results_per_page,
                "safe_search"   : safe_search
        ]
        
        Alamofire.request(.GET, base_url, parameters: parameters, encoding: .URL, headers: nil)
            .validate()
            .responseJSON
            {
                response in
                guard response.result.isSuccess else
                {
                    print("\(response.result.error)")
                    return
                }
                
                guard let responseJSONValue = response.result.value as? [String: AnyObject] else
                {
                    print(response.result)
                    return
                }
                let json = JSON(responseJSONValue)
                var photos:[ImageData] = [ImageData]()
                for photo in json["photos"]["photo"].arrayValue
                {
                    if let photoUrl = photo["url_m"].string
                    {
                        let title = photo["title"].stringValue
                        let photoWidth = photo["width_m"].intValue
                        let photoHeight = photo["height_m"].intValue
                        let photo = ImageData(title: title, url: photoUrl, width: photoWidth, height: photoHeight)
                        photos.append(photo)
                    }
                }
                completionHandler(photos: photos)
        }
    }
    
    func getImageData(urlString:String, completionHandler:(image:UIImage) -> Void) -> Request
    {
        return Alamofire.request(.GET, urlString)
            .validate()
            .responseImage
            {
                (response) -> Void in
                guard let image = response.result.value else { return }
                completionHandler(image: image)
        }
    }
}