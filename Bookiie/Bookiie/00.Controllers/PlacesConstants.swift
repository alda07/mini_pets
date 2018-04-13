//
//  PlacesConstants.swift
//  Bookiie
//
//  Created by HanhVo on 5/14/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//


import Foundation

extension AddressSearchClient {
    
    struct Constants{
        static let BaseURL: String = "https://maps.googleapis.com/maps/api/geocode/json?"
    }
    
    struct ParameterKeys{
        static let AddressKey: String = "address="
    }
    struct JSONResponseKeys{
        static let Results: String = "results"
        static let Status: String = "status"
        static let FormattedAddress: String = "formatted_address"
        static let Geometry: String = "geometry"
        static let Location: String = "location"
        static let Lat: String = "lat"
        static let Lng: String = "lng"
        static let Sensor: String = "&sensor=false"
        static let Photos: String = "photos"
        static let PhotoRef: String = "photo_reference"
    }
}