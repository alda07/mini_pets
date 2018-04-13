//
//  BookedDetailController.swift
//  Bookiie
//
//  Created by HanhVo on 5/16/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit
import MapKit

class BookedDetailController: UIViewController {
    
    @IBOutlet weak var lbRestaurantName: UILabel!
    @IBOutlet weak var lbBookingTime: UILabel!
    @IBOutlet weak var lbNumberOfPeople: UILabel!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Actions
    @IBAction func rateTapped(sender: AnyObject) {
        
    }
    
    @IBAction func callTapped(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string:"telprompt:01217151105")!)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
    }
    
    @IBAction func backTapped(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func adddressTapped(sender: AnyObject) {
        
        let lat1 : NSString = "10.782522"
        let lng1 : NSString = "106.689567"
        
        let latitute:CLLocationDegrees =  lat1.doubleValue
        let longitute:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitute, longitute)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Au Manoir De Khai"
        mapItem.openInMapsWithLaunchOptions(options)
        
    }
    
    // MARK: Methods
    func configureUI()  {
        
        // for rateButton
        rateButton.titleLabel?.textColor = YellowTheme
        rateButton.layer.borderColor = YellowTheme.CGColor
        rateButton.layer.borderWidth = 0.5
        rateButton.layer.cornerRadius = 4.0
        
        // for callButton
        callButton.titleLabel?.textColor = GreenTheme
        callButton.layer.borderColor = GreenTheme.CGColor
        callButton.layer.borderWidth = 0.5
        callButton.layer.cornerRadius = 4.0
        
        
        // for menuButton
        cancelButton.titleLabel?.textColor = UIColor.redColor()
        cancelButton.layer.borderColor = UIColor.redColor().CGColor
        cancelButton.layer.borderWidth = 0.5
        cancelButton.layer.cornerRadius = 4.0
        
    }
    
}
