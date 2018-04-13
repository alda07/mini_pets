//
//  RestaurantDetail.swift
//  Bookiie
//
//  Created by HanhVo on 5/15/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetail: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bookButton: UIButton!
    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: Methods
    func configureUI() {
        
        // for bottomView
        bottomView.layer.borderColor = UIColor.darkGrayColor().CGColor
        bottomView.layer.borderWidth = 0.5
        bottomView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.8)
        
        // for bookButton
        bookButton.layer.borderColor = GreenTheme.CGColor
        bookButton.layer.borderWidth = 0.5
        bookButton.layer.cornerRadius = 4.0

    }
    
    //MARK: Actions
    @IBAction func bookTapped(sender: AnyObject) {
        
        let storyBoardName: NSString = Common.storyBoardName(.Booking)
        let content = storyboard!.instantiateViewControllerWithIdentifier(storyBoardName as String) as! BookingController
        presentViewController(content, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}