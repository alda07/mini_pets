//
//  BookieController.swift
//  Bookiie
//
//  Created by HanhVo on 5/15/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class BookieController: UIViewController {

    @IBOutlet weak var bookiieTable: UITableView!
    @IBOutlet weak var optionsButton: UIButton!
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Methods
    func configureUI()  {
        
        // for bookiieTable
        bookiieTable.separatorStyle = .None
        bookiieTable.delegate = self
        bookiieTable.dataSource = self
        
        // for optionsButton
        optionsButton.layer.cornerRadius = 4.0
    }
 
}

extension BookieController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "AHCell"
        var cell : AHCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? AHCell
        
        if cell == nil {
            cell = AHCell.fromNib()
            cell?.restorationIdentifier = cellID
        }
        
        return cell!
        
    }

}

extension BookieController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let storyBoardName: NSString = Common.storyBoardName(.RestaurantDetail)
        let content = storyboard!.instantiateViewControllerWithIdentifier(storyBoardName as String) as! RestaurantDetail
        presentViewController(content, animated: true, completion: nil)
        
        
    }
}

extension BookieController:UIPopoverPresentationControllerDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == BookieSegue.Options.rawValue {
            
            let popoverViewController = segue.destinationViewController as! OptionsController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            popoverViewController.popoverPresentationController!.delegate = self
            popoverViewController.preferredContentSize = CGSizeMake(view.bounds.width,250.0);
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
}
