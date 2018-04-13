//
//  AppConfigure.swift
//  Photo
//
//  Created by HanhVo on 8/2/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import Foundation

class Configure {
    
    let isFirstLauchKey = "isFirstLauchKey"
    
    //MARK:- Properties
    static let sharedInstance = Configure()
    
    //MARK:- Public methods
    func isFirstLauch() -> Bool {
        
        return NSUserDefaults.standardUserDefaults().boolForKey(isFirstLauchKey)
    }
    
    func setLauched(isLauched: Bool) {
        
        NSUserDefaults.standardUserDefaults().setBool(isLauched, forKey: isFirstLauchKey)
    }
    
    
}
