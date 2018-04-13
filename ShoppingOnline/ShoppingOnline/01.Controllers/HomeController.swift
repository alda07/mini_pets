//
//  HomeController.swift
//  ShoppingOnline
//
//  Created by HanhVo on 7/10/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

import DropDown

class HomeController: BaseController,
                      UICollectionViewDataSource,
                      UICollectionViewDelegate
{
    
    //MARK: UI
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var keyWord: UITextField!
    
    @IBOutlet weak var searchFilter: UIView!
    @IBOutlet weak var currentFilter: UILabel!
    @IBOutlet weak var openFilters: UIButton!
    
    @IBOutlet weak var productList: UICollectionView!
    
    let sortedDropDown = DropDown()
    var refreshControl:UIRefreshControl!
    
    //MARK: Properties
    var productArray:Array<Product>?

    //MARK: Life Cycle
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // remove all data
        removeData()
        
        // get data from service
        requestProductData(false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // for beginning
        createDefaultViews()
    }

    //MARK: Methods
    func createDefaultViews()  {
        
        // navigation
        self.title = "PRODUCTS"
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        //favItem
        let favItem:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeController.addFavorites))
        favItem.image = UIImage(named: "fav")
        
        //buyItem
        let buyItem:UIBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeController.buy))
        buyItem.image = UIImage(named: "shopping-cart")
        
        navigationItem.setRightBarButtonItems([favItem,buyItem], animated: true)
        
        //searchView
        searchView.backgroundColor = UIColor.lightGrayColor()
        
        //searchButton
        searchButton.backgroundColor = UIColor.whiteColor()
        searchButton.layer.borderWidth = 0.5
        searchButton.layer.borderColor = UIColor.grayColor().CGColor
        searchButton.enabled = false
        
        //keyWord
        keyWord.backgroundColor = UIColor.whiteColor()
        keyWord.layer.borderWidth = 0.5
        keyWord.layer.borderColor = UIColor.grayColor().CGColor
        keyWord.addTarget(self, action: #selector(HomeController.searchTextFieldChanged(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        let paddingView = UIView(frame:CGRectMake(0, 0, 5, keyWord.bounds.size.height))
        keyWord.leftView=paddingView;
        keyWord.leftViewMode = UITextFieldViewMode.Always
        
        //searchFilter
        searchFilter.backgroundColor = UIColor.clearColor()
        
        //currentFilter
        currentFilter.text = "TITLE : A - Z";
        
        //dropDown
        sortedDropDown.anchorView = currentFilter
        sortedDropDown.dataSource = ["TITLE : A - Z","TITLE : Z - A", "PRICE: LOW - HIGH", "PRICE: HIGH - LOW" ]
        sortedDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.currentFilter.text = item
            self.sortProducts(index)
        }
        
        // for productArray
        productArray = Array<Product>()
        
        // init for productList
        productList.dataSource = self
        productList.delegate = self
        
        // refresher
        refreshControl = UIRefreshControl()
        productList!.alwaysBounceVertical = true
        refreshControl.tintColor = UIColor.blackColor()
        refreshControl.addTarget(self, action: #selector(pullToRequest), forControlEvents: .ValueChanged)
        productList!.addSubview(refreshControl)

    }
    
    func refreshData()  {
        
        // reload productList
        productList.reloadData()
    }
    
    func removeData()  {
        
        // reload productList
        productArray?.removeAll()
    }
    
    func pullToRequest()
    {
        // get data from service
        requestProductData(true)
    }
    
    func stopRefresher()
    {
        refreshControl.endRefreshing()
    }
    
    func sortProducts(index:Int)  {
        
        // get filter
        switch index {
        case 0:
            productArray!.sortInPlace({ $0.title < $1.title })
            break
        case 1:
            productArray!.sortInPlace({ $0.title > $1.title })
            break
        case 2:
            productArray!.sortInPlace({ $0.price < $1.price })
            break
        case 3:
            productArray!.sortInPlace({ $0.price > $1.price })
            break
        default:
            break
            
        }
        
        refreshData()
        sortedDropDown.hide()
    }
    
    func searchTextFieldChanged(textField: UITextField)  {
        
        if  ((textField.text?.isEmpty) != true)
        {
             searchButton.enabled = true
        }
        else
        {
             searchButton.enabled = false
        }
    }
    
    //MARK: Actions
    @IBAction func searchTapped(sender: AnyObject) {
        
        // make a request to search
        self.searchProductData(keyWord.text!)
        
        // hide keyboard
        keyWord.resignFirstResponder()

    }
    
    @IBAction func searchOptionsTapped(sender: AnyObject) {
        
        sortedDropDown.show()
    }
    
    @IBAction func viewMoreTapped(sender: AnyObject) {
    }
    
    //MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productArray!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        cell.setContentForUI(productArray![indexPath.row])

        return cell
    }
    
    //MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        var height : CGFloat
        productArray?.count > 0 ? (height = 50.0) : (height = 0.0)
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        var height : CGFloat
        productArray?.count > 0 ? (height = 50.0) : (height = 0.0)
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), height)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ProductHeaderView", forIndexPath: indexPath)
            
            // get label content
            let headerLabel = headerView.viewWithTag(1) as? UILabel
            headerLabel!.text = String(format: "%d ITEMS", (productArray?.count)!)
            
            return headerView
            
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ProductFooterView", forIndexPath: indexPath)
            
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let cellWidth = view.bounds.width / 2 - 40.0
        let cellHeight = cellWidth + cellWidth / 2
        
        return CGSize(width: cellWidth, height:cellHeight)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "productSegue" {
            
            // Get selected index
            let indexPaths : NSArray = productList.indexPathsForSelectedItems()!
            let selectedIndex = (indexPaths[0] as! NSIndexPath).row
            
            // Get selected product
            let selectedProduct = self.productArray![selectedIndex]
            
            // Asign data for DetailController
            let detailController = segue.destinationViewController as! DetailController
            detailController.setProductDetail(selectedProduct)
            detailController.setRelatedProducts(self.productArray!)
            
        }
    }
    
}
