//
//  RestaurantDetailContainerController.swift
//  Bookiie
//
//  Created by HanhVo on 5/16/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailContainerController: UIViewController {

    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lbAbout: UITextView!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
  
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions
    @IBAction func menuTapped(sender: AnyObject) {
    }
    
    @IBAction func websiteTapped(sender: AnyObject) {
    }
    
    @IBAction func MapTapped(sender: AnyObject) {
        
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
    
   // MARK: - Methods
    func configureUI()  {
        
        // for websiteButton
        websiteButton.layer.borderColor = SalmonTheme.CGColor
        websiteButton.layer.borderWidth = 0.5
        websiteButton.layer.cornerRadius = 4.0
        
        
        // for menuButton
        menuButton.layer.borderColor = SalmonTheme.CGColor
        menuButton.layer.borderWidth = 0.5
        menuButton.layer.cornerRadius = 4.0

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
