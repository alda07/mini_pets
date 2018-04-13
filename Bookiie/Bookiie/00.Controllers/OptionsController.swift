//
//  OptionsController.swift
//  Bookiie
//
//  Created by HanhVo on 5/16/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class OptionsController: UIViewController,
    AHPickerDelegate
{
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tfCuisine: UITextField!
    @IBOutlet weak var tflocation: UITextField!
    @IBOutlet weak var tfOthers: UITextField!
    @IBOutlet weak var showOptionButton: UIButton!
    
    var cuisinePicker:AHPicker?
    var othersPicker:AHPicker?
    
    // MARK: - Life Style
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confureUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cuisineTextFieldEditing(sender: UITextField) {
        
        let dataList = ["Tất cả","Món Việt Nam", "Món Nhật", "Món Thái Lan", "Món Ấn Độ", "Món Hoa", "Món Pháp", "Món Ý"]
        let frame = CGRect(origin: view.center, size: CGSize(width: view.frame.width, height: view.frame.width * 2/3))
        cuisinePicker = AHPicker()
        cuisinePicker!.initPicker(dataList, iFrame: frame, iPickerType: .Cuisine)
        cuisinePicker!.showPicker(sender)
        cuisinePicker!.delegate = self
    }
    
    @IBAction func locationTextFieldEditing(sender: UITextField) {
        
        let storyBoardName: NSString = Common.storyBoardName(.MapNavigation)
        let content = storyboard!.instantiateViewControllerWithIdentifier(storyBoardName as String) as! UINavigationController
        showDetailViewController(content, sender: sender)
    }
    
    @IBAction func othersTextFieldEditing(sender: UITextField) {
        
        let dataList = ["Tất cả","Giảm giá ", "Ăn trưa", "Ăn tối", "Rating cao"]
        let frame = CGRect(origin: view.center, size: CGSize(width: view.frame.width, height: view.frame.width * 2/3))
        othersPicker = AHPicker()
        othersPicker!.initPicker(dataList, iFrame: frame, iPickerType: .Others)
        othersPicker!.showPicker(sender)
        othersPicker!.delegate = self
    }
    
    
    // MARK: - Methods
    func confureUI() {
        
        // tfCuisine
        tfSearch.setLeftIcon(BookiieTextField.Cuisine.rawValue)
        tfSearch.textColor  = UIColor.darkGrayColor()
        
        // tfCuisine
        tfCuisine.setLeftIcon(BookiieTextField.Cuisine.rawValue)
        tfCuisine.textColor  = UIColor.darkGrayColor()
        
        // tflocation
        tflocation.setLeftIcon(BookiieTextField.Location.rawValue)
        tfCuisine.textColor  = UIColor.darkGrayColor()
        
        // tfOthers
        tfOthers.setLeftIcon(BookiieTextField.Others.rawValue)
        tfOthers.textColor  = UIColor.darkGrayColor()
        
    }
    
    //MARK: AHPickerDelegate
    func ahPickerSelected(sender:AHPicker,content:String) {
        
        if (sender.pickerType == .Cuisine)
        {
            tfCuisine.text = content
            
        } else {
            
            tfOthers.text = content
        }
        
    }
    
    
    func ahPickerDoneTapped(sender:AHPicker) {
        
        
        if (sender.pickerType == .Cuisine)
        {
            tfCuisine.resignFirstResponder()
            
        } else {
            
            tfOthers.resignFirstResponder()
        }
    }
}
