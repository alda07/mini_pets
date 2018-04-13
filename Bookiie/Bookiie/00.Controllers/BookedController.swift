//
//  BookedController.swift
//  Bookiie
//
//  Created by HanhVo on 5/16/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class BookedController: UIViewController {
    
    @IBOutlet weak var bookedTable: UITableView!
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func upTapped(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Methods
    func configureUI()  {
        
        // for bookedTable
        bookedTable.separatorStyle = .None
        bookedTable.delegate = self
        bookedTable.dataSource = self
        
    }

}

extension BookedController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellID = "AHBookedCell"
        var cell : AHBookedCell? = tableView.dequeueReusableCellWithIdentifier(cellID) as? AHBookedCell
        
        if cell == nil {
            cell = AHBookedCell.fromNib()
            cell?.restorationIdentifier = cellID
        }
        
        return cell!
        
    }
    
}

extension BookedController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyBoardName: NSString = Common.storyBoardName(.BookedDetail)
        let content = storyboard!.instantiateViewControllerWithIdentifier(storyBoardName as String) as! BookedDetailController
        presentViewController(content, animated: true, completion: nil)
    }
}

