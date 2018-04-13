//
//  DetailController.swift
//  ShoppingOnline
//
//  Created by HanhVo on 7/11/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

import DropDown

class DetailController: BaseController,
                        UICollectionViewDataSource {
    
    //MARK: UI
    
    // Top
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    // Mid
    @IBOutlet weak var selectedColorLabel: UILabel!
    @IBOutlet weak var backgroundColorDropList: UIView!
    @IBOutlet weak var colorButton: UIButton!
    
    @IBOutlet weak var sizeBackground: UIView!
    @IBOutlet weak var sizeSelectedLabel: UILabel!
    @IBOutlet weak var sizeButton: UIButton!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    // Product Description
    @IBOutlet weak var descriptionContent: UILabel!
    
    //ButtonsView
    @IBOutlet weak var aditionalInfo: UILabel!
    @IBOutlet weak var productTags: UILabel!
    @IBOutlet weak var productReview: UILabel!
    @IBOutlet weak var stockData: UILabel!
    @IBOutlet weak var productTestimonails: UILabel!
    
    //RelatedView
    @IBOutlet weak var relatedProductList: UICollectionView!
    
    
   
    var colorDropDown: DropDown?
    var sizeDropDown: DropDown?
    
    //MARK: Properties
    var product : Product?
    var relatedproducts : Array<Product>?

    var selectedColor: String?
    var selectedSize: String?
    var quantity : Int = 1
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDefaultViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //configureForBeginning
        configureForBeginning()
    }
    
    //MARK: Actions
    @IBAction func colorDropDownTapped(sender: AnyObject) {
        
        colorDropDown?.show()
    }
    
    @IBAction func sizeDropDownTapped(sender: AnyObject) {
        
        sizeDropDown?.show()
    }
    
    @IBAction func quantitySubstractTapped(sender: AnyObject) {
        
        quantity < 2 ? (quantity = 1) : (quantity = quantity - 1)
        
        quantityLabel.text = String(format: "%d", quantity)
    }
    
    @IBAction func quantityPlusTapped(sender: AnyObject) {
        
        quantity > 100 ? (quantity = 100) : (quantity = quantity + 1)
        
        quantityLabel.text = String(format: "%d", quantity)
    }

    //MARK: Methos
    func setProductDetail(detail: Product)  {
        
        product = detail
    }
    
    func setRelatedProducts(products: Array<Product>)  {
        
        relatedproducts = products
    }
    
    func configureForBeginning() {
        
        // ***************TOP****************
        // titleLabel
        titleLabel.text = product?.title
        
        // priceLabel
        priceLabel.text = String(format: "$ %.2f", (product?.price)!)
        
        // brandLabel
        brandLabel.text = product?.brand
        
        // ***************MID****************
        // selectedColorLabel
        selectedColorLabel.text = product?.colors![0]
        
        // backgroundColorDropList
        backgroundColorDropList.layer.borderColor = UIColor.darkGrayColor().CGColor
        backgroundColorDropList.layer.borderWidth = 0.5
        backgroundColorDropList.backgroundColor = UIColor.whiteColor()
        
        // sizeSelectedLabel
        sizeSelectedLabel.text = product?.sizes![0]
        
        // sizeBackground
        sizeBackground.layer.borderColor = UIColor.darkGrayColor().CGColor
        sizeBackground.layer.borderWidth = 0.5
        sizeBackground.backgroundColor = UIColor.whiteColor()
        
        // quantityLabel
        quantityLabel.text = String(format: "%d", quantity)
        
        // ***************BUTTONSVIEW****************
        
        //aditionalInfo
        aditionalInfo.layer.borderWidth = 0.5
        aditionalInfo.layer.borderColor = UIColor.blackColor().CGColor
        
        //productTags
        productTags.layer.borderWidth = 0.5
        productTags.layer.borderColor = UIColor.blackColor().CGColor
        
        //productReview
        productReview.layer.borderWidth = 0.5
        productReview.layer.borderColor = UIColor.blackColor().CGColor
        
        //stockData
        stockData.layer.borderWidth = 0.5
        stockData.layer.borderColor = UIColor.blackColor().CGColor
        
        //productTestimonails
        productTestimonails.layer.borderWidth = 0.5
        productTestimonails.layer.borderColor = UIColor.blackColor().CGColor
        
        // ***************RELATEDVIEW****************
        
        //relatedProductList
        relatedProductList.dataSource = self
    }
    
    func createDefaultViews() {
        
        // self
        self.title = product?.title?.uppercaseString
        
        //favItem
        let favItem:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeController.addFavorites))
        favItem.image = UIImage(named: "fav")
        
        
        //buyItem
        let buyItem:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeController.buy))
        buyItem.image = UIImage(named: "shopping-cart")
        
        navigationItem.setRightBarButtonItems([favItem,buyItem], animated: true)
        
        //colorDropDown
        colorDropDown = DropDown()
        colorDropDown!.anchorView = selectedColorLabel
        colorDropDown!.dataSource = (product?.colors)!
        colorDropDown!.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.selectedColorLabel.text = item
            self.selectedColor = item
        }
        
        //colorDropDown
        sizeDropDown = DropDown()
        sizeDropDown!.anchorView = sizeSelectedLabel
        sizeDropDown!.dataSource = (product?.sizes)!
        sizeDropDown!.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.sizeSelectedLabel.text = item
            self.selectedSize = item
        }
        
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "imagePickerSegue" {
            
            // Asign data for DetailController
            let imagePickerController = segue.destinationViewController as! ImageGalleryController
            imagePickerController.setImageList((product?.detailImages)!)
        }
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return relatedproducts!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RelatedProductCell", forIndexPath: indexPath) as! ProductCell
        cell.setContentForUI(relatedproducts![indexPath.row])
        
        return cell
    }

}
