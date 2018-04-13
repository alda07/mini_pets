//
//  AHPicker.swift
//  Bookiie
//
//  Created by HanhVo on 5/15/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

protocol AHPickerDelegate  {
    
    func ahPickerSelected(sender:AHPicker,content:String)
    func ahPickerDoneTapped(sender:AHPicker)
}

class AHPicker: UIView,
                UIPickerViewDelegate,
                UIPickerViewDataSource
{
    enum PickerType:Int {
        
        case Cuisine
        case NumberOfPeople
        case Others
    }
    
    let doneTitle = "Done"
    var datalist:NSArray?
    var delegate:AHPickerDelegate?
    var pickerType:PickerType?
    
    
    // MARK: Methods
    func initPicker(data:NSArray,iFrame:CGRect, iPickerType:PickerType)  {
        
        datalist = NSArray(array: data)
        pickerType = iPickerType
        frame = iFrame
    }
 
    func showPicker(sender: UITextField)
    {
        
        // create the view
        let inputView = UIView(frame: self.frame)
   
        // for datePickerView
        let pickerView = UIPickerView(frame: inputView.bounds)
        pickerView.backgroundColor = UIColor.whiteColor()
        pickerView.layer.borderColor = UIColor.darkGrayColor().CGColor
        pickerView.layer.borderWidth = 0.5
        pickerView.layer.cornerRadius = 4.0
        pickerView.setValue(UIColor.darkGrayColor(), forKey: "textColor")
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(firstSelectedRow(), inComponent: 0, animated: false)
     
        inputView.addSubview(pickerView)
        
        // for doneButton
        let doneButton = UIButton(frame: CGRectMake(0, 0, inputView.frame.size.width, 40.0))
        doneButton.setTitle(doneTitle, forState: UIControlState.Normal)
        doneButton.setTitle(doneTitle, forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        doneButton.backgroundColor = GreenTheme
        inputView.addSubview(doneButton)
        doneButton.addTarget(self, action:#selector(doneButtonTappped), forControlEvents: UIControlEvents.TouchUpInside)
        
        // assign textfield's inputView
        sender.inputView = inputView
        sender.text = pickerItemString(firstSelectedRow())
        
    }
    
    func firstSelectedRow() -> Int {
        
        let centerRow = ((datalist?.count)! / 2) as Int

        if pickerType == .NumberOfPeople {
            
            return 0
        }
        return centerRow
    }
    
    func doneButtonTappped() {
        
          delegate!.ahPickerDoneTapped(self)
    }
    
    // MARK: UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return (datalist?.count)!
    }

    
    // MARK: UIPickerViewDelegate

    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string: pickerItemString(row), attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        delegate!.ahPickerSelected(self,content: pickerItemString(row))
    }
    
    func pickerItemString(selectedIndex: Int) -> String {
        
        let resultString =  datalist![selectedIndex] as! String
        return resultString
    }
    
   
}
