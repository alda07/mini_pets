//
//  DetailsController.swift
//  Photo
//
//  Created by HanhVo on 8/2/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

import Alamofire

class DetailsController: UIViewController {
    
    //MARK: UI
    @IBOutlet weak var imageView : UIImageView?
    
    //MARK: Properties
    var request:Request?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DetailsController.actionClose(_:))))
    }
    
    //MARK: Methods
    func reset()
    {
        imageView!.image = nil
        request?.cancel()
    }
    
    func actionClose(tap: UITapGestureRecognizer) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setImage(index:NSInteger) {
        
        request = PhotoLibrary.shareInstance.loadPhoto(index)
        {
            image in
            self.imageView!.image = image
        }
    }
}
