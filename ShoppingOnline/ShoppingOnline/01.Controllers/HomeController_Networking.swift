//
//  HomeController_Networking.swift
//  ShoppingOnline
//
//  Created by HanhVo on 7/10/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import Foundation

import Alamofire
import KRProgressHUD

extension HomeController {
    
    func  requestProductData(isPullToRefresh: Bool)  {
        
        if !isPullToRefresh {
            
            // Show indicator
            KRProgressHUD.show()
            
        }
      
        // Call to service
        Alamofire.request(.GET,SERVICE_URL ).responseJSON { response in
                do {
                    // get json array
                    let  jsonArray = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions()) as? Array<NSDictionary>
                    
                    // parse to product array
                    var parsedProduct = Array<Product>()
                    for  dic: NSDictionary in jsonArray! {
                        
                        parsedProduct.append(Product.init(jsonDictionary: dic))
                    }
                    
                    // refreshdata
                    self.productArray?.appendContentsOf(parsedProduct)
                    self.refreshData()
                    
                    if !isPullToRefresh {
                        
                        // Hide indicator
                        KRProgressHUD.dismiss()
                    }
                    else {
                        
                        //pull to refresh
                        self.stopRefresher()
                    }
                    
                } catch {
                    
                    print(error)
                    
                    // Hide indicator
                    KRProgressHUD.dismiss()
                }
        }
    }
    
    func  searchProductData(keyword:String)  {
        
        // Show indicator
        KRProgressHUD.show()
        
        // Call to service
        Alamofire.request(.GET,SERVICE_URL ).responseJSON { response in
            do {
  
                // Hide indicator
                KRProgressHUD.dismiss()
                
            } catch {
                print(error)
                
                // Hide indicator
                KRProgressHUD.dismiss()
            }
        }
    }

}

