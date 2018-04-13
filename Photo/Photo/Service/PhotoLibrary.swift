//
//  PhotoLibrary.swift
//  Photo
//
//  Created by HanhVo on 8/2/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage


protocol PhotoLibraryDataSource
{
    func numberOfPhotos(keyword:String, completionHandler:(photos:[ImageData]) -> Void)
    func loadPhoto(index:Int, completionHandler:(image:UIImage?) -> Void) -> Request?
}

class PhotoLibrary:PhotoLibraryDataSource
{
    //MARK: Properties
    static let shareInstance = PhotoLibrary()
    private var photos:[ImageData] = [ImageData]()
    private let photoCache = AutoPurgingImageCache(memoryCapacity: 100 * 1024 * 1024, preferredMemoryUsageAfterPurge: 60 * 1024 * 1024)
    
    //MARK: Private Methods
    private init(){}
    
    //MARK: Public Methods
    func loadPhoto(index: Int, completionHandler: (image: UIImage?) -> Void) -> Request?
    {
        if(index >= 0 && index < photos.capacity)
        {
            let urlString = photos[index].url
            
            //check the cache first
            if let cachedImage = getImageFromCache(urlString)
            {
                completionHandler(image: cachedImage)
            }
                
                //make network request if image not in cache
            else
            {
                var networkImage:UIImage?
                let request =
                    PhotoService.sharedInstance.getImageData(urlString)
                    {
                        [unowned self]
                        image in
                        networkImage = image
                        completionHandler(image: networkImage)
                        self.addImageToCache(networkImage, urlString: urlString)
                }
                return request
            }
        }
        return nil
    }
    
    func numberOfPhotos(keyword: String, completionHandler:(photos:[ImageData]) -> Void)
    {
        PhotoService.sharedInstance.getPhotos(keyword)
        {
            [unowned self]
            (photos:[ImageData]) -> Void in
            self.photos = photos
            completionHandler(photos: photos)
        }
    }
    
    //MARK: Private Helpers
    private func getImageFromCache(urlString:String) -> UIImage?
    {
        return photoCache.imageWithIdentifier(urlString)
    }
    
    private func addImageToCache(image:UIImage?, urlString:String)
    {
        if let networkImage = image
        {
            photoCache.addImage(networkImage, withIdentifier: urlString)
        }
    }
}

