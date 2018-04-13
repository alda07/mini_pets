//
//  ImageGalleryController.swift
//  ShoppingOnline
//
//  Created by HanhVo on 7/11/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class ImageGalleryController: BaseController,
                              UICollectionViewDataSource,
                              UICollectionViewDelegate {

    //MARK: UI
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var imageListView: UICollectionView!
    
    //MARK: Properties
    var imageArray: Array<ProductImage>?;
    var selectedIndex: Int = 0
    
    //MARK: Life Cycle
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // configureForBeginning
        configureForBeginning()
    }
    
    //MARK: Actions
    
    @IBAction func prevButtonTapped(sender: AnyObject) {
        
        (selectedIndex > 0) ? (selectedIndex = selectedIndex - 1) : (selectedIndex = 0)
        
        mainImage.kf_setImageWithURL(NSURL(string:(imageArray![selectedIndex] as ProductImage).url as! String)!)
    }
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        
        (selectedIndex < (imageArray?.count)! - 1) ? (selectedIndex = selectedIndex + 1) : (selectedIndex = (imageArray?.count)! - 1)
        
        mainImage.kf_setImageWithURL(NSURL(string:(imageArray![selectedIndex] as ProductImage).url as! String)!)
    }
    
    //MARK: Methods
    func configureForBeginning()  {
   
        // init for imageListView
        imageListView.dataSource = self
        imageListView.delegate = self
        
        // alway set main image as index = 0
        mainImage.kf_setImageWithURL(NSURL(string:(imageArray![0] as ProductImage).url as! String)!)

    }
    
    func setImageList(list:Array<ProductImage>)  {
        
        // remove fresh when calling
        (imageArray != nil) ? (imageArray?.removeAll()) : (imageArray = Array<ProductImage>())

        // assign image list
        imageArray = list
        
    }

    //MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductImageCell", forIndexPath: indexPath) as! ProductImageCell
        cell.setContentForUI(imageArray![indexPath.row])
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // assign selected index
        selectedIndex = indexPath.row
        
        // alway set main image as index = indexPath.row
        mainImage.kf_setImageWithURL(NSURL(string:(imageArray![indexPath.row] as ProductImage).url as! String)!)
    }

}
