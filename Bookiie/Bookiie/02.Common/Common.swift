//
//  Common.swift
//  Bookiie
//
//  Created by HanhVo on 5/15/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import Foundation

// XIBS
let kAHRatingViewXIB = "AHRatingView"
let kAHCellXIB = "AHCell"

enum BookieSegue: String
{
    case Menu = "presentMenu"
    case MainNavigation = "embedMainNavigation"
    case MapView = "presentMapView"
    case Options = "presentOptionsPopover"
    
}

enum BookiieTextField: String
{
    case Date = "date"
    case Time = "time"
    case Cuisine = "cuisine"
    case NumberPeople = "number_people"
    case Location = "location"
    case Others = "others"
}


enum BookieStoryBoard: Int
{
    case Bookie
    case SecrectDeal
    case Profile
    case Help
    case RestaurantDetail
    case Options
    case MapNavigation
    case Booking
    case BookedDetail
    
}

 class Common {
    
    static func storyBoardName(selectedIndex:Int) -> String
    {
        let selectedStoryboard: BookieStoryBoard = BookieStoryBoard.init(rawValue: selectedIndex)!
        
        switch selectedStoryboard {
            
        case .Bookie:
            return "BookieController"
            
        case .SecrectDeal:
            return "SecrectDealsController"
            
        case .Profile:
            return "ProfileController"
            
        case .Help:
            return "HelpController"
            
        case .RestaurantDetail:
            return "RestaurantDetail"
            
        case .Options:
            return "OptionsController"
            
        case .MapNavigation:
            return "MapNavigation"
            
        case .Booking:
            return "BookingController"
            
        case .BookedDetail:
            return "BookedDetailController"

        }
    }
    
    static func storyBoardName(selectedStoryboard:BookieStoryBoard) -> String
    {
        
        switch selectedStoryboard {
            
        case .Bookie:
            return "BookieController"
            
        case .SecrectDeal:
            return "SecrectDealsController"
            
        case .Profile:
            return "ProfileController"
            
        case .Help:
            return "HelpController"
        case .RestaurantDetail:
            return "RestaurantDetail"
        
        case .Options:
            return "OptionsController"
            
        case .MapNavigation:
            return "MapNavigation"
            
        case .Booking:
            return "BookingController"

        case .BookedDetail:
            return "BookedDetailController"
        }
    }
}



