//
//  MainController.swift
//  Photo
//
//  Created by HanhVo on 8/2/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit
import AVFoundation

import EasyTipView

class MainController: UIViewController {
    
    //MARK: UI
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Properties
    var photos:[ImageData] = [ImageData]()
    var selectedImage: UIImageView?
    
    var searchTipView : EasyTipView!
    var collectionTipView : EasyTipView!
    let transition = PopTransition()
    
    //MARK: Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // for searchTextField
        searchTextField.delegate = self
        
        // collection layout
        if let layout = collectionView?.collectionViewLayout as? MainCollectionStyle
        {
            layout.delegate = self
        }
        
        // show tool tip in the first time opening app
        showToolTip()
    }
}

//MARK:- UICollectionViewDataSource
extension MainController: UICollectionViewDataSource
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MainCell", forIndexPath: indexPath) as? MainCell
        
        //reset the cell and cancel any in flight network requests
        cell?.loadingIndicator.startAnimating()
        cell?.loadingIndicator.hidden = false
        cell?.imageView.image = nil
        cell?.request?.cancel()
        
        //load Image from library
        cell?.request = PhotoLibrary.shareInstance.loadPhoto(indexPath.item)
        {
            image in
            cell?.imageView.image = image
            cell?.loadingIndicator.stopAnimating()
            cell?.loadingIndicator.hidden = true
        }
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        let  cell  = collectionView.cellForItemAtIndexPath(indexPath) as? MainCell
        self.selectedImage = cell?.imageView
        
        let details = storyboard!.instantiateViewControllerWithIdentifier("DetailsController") as! DetailsController
        
        details.transitioningDelegate = self
        presentViewController(details, animated: true, completion: nil)
        details.setImage(indexPath.row)

    }
}

//MARK: MainCollectionStyleDelegate
extension MainController:MainCollectionStyleDelegate
{
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexpath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
    {
        let photo = photos[indexpath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRectWithAspectRatioInsideRect(photo.getSize(), boundingRect)
        return rect.size.height
    }
}

//MARK: UITextFieldDelegate
extension MainController: UITextFieldDelegate
{
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityIndicator.frame = textField.bounds
        textField.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        
        if textField.text?.characters.count > 0
        {
            
            PhotoLibrary.shareInstance.numberOfPhotos(textField.text!)
            {
                [unowned self]
                (photos:[ImageData]) -> Void in
                self.photos = photos
                dispatch_async(dispatch_get_main_queue())
                {
                    activityIndicator.removeFromSuperview()
                    self.collectionView.reloadData()
                    self.dismisTooltips()
                }
            }
        }
        else
        {
            activityIndicator.removeFromSuperview()
        }
        textField.resignFirstResponder()
        return true
    }
}

extension MainController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
                             sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            
            transition.originFrame = selectedImage!.superview!.convertRect(selectedImage!.frame, toView: nil)
            transition.presenting = true
            
            return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

//MARK:- Easy Tool tip
extension MainController
{
    func showToolTip()  {
        
        if (Configure.sharedInstance.isFirstLauch() != true) {
            
            var preferences = EasyTipView.globalPreferences
            preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.Bottom
            preferences.drawing.font = UIFont.systemFontOfSize(14)
            preferences.drawing.backgroundColor = UIColor .blackColor()
            preferences.animating.dismissTransform = CGAffineTransformMakeTranslation(100, 0)
            preferences.animating.showInitialTransform = CGAffineTransformMakeTranslation(100, 0)
            preferences.animating.showInitialAlpha = 0
            preferences.animating.showDuration = 1
            preferences.animating.dismissDuration = 1
            
            searchTipView = EasyTipView(text: "Put your key word here!", preferences: preferences)
            collectionTipView = EasyTipView(text: "Images will appear.", preferences: preferences)
            
            searchTipView.show(forView: searchTextField)
            collectionTipView.show(forView: collectionView)
            
        }
        
        Configure.sharedInstance.setLauched(true)
    }
    
    func dismisTooltips()  {
        
        if searchTipView != nil  {
            
            searchTipView.dismiss()
        }
        
        if collectionTipView != nil {
            
            collectionTipView.dismiss()
        }
    }
}
