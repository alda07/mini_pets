//
//  BookiieDatePicker.swift
//  Bookiie
//
//  Created by HanhVo on 5/14/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit
import Foundation


class AHDateTimePicker: UIView {
    
    enum DateTimePickerType:Int {
        
        case Time
        case Date
    }
    
    let doneTitle = "Done"
    let dateInOneMonthFromNow = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 3, toDate: NSDate(), options: [])
    var pickerType: DateTimePickerType?
    
    func showDateTimePicker(sender: UITextField, doneSelector:Selector, valuechangeSelector: Selector )
    {
        
        // Create the view
        let inputView = UIView(frame: self.frame)
        
        // for datePickerView
        let datePickerView  : UIDatePicker = UIDatePicker(frame: inputView.bounds)
        datePickerView.minimumDate = NSDate()
        datePickerView.maximumDate = dateInOneMonthFromNow
        datePickerView.datePickerMode = convertPickerToDateTimeType()
        datePickerView.backgroundColor = UIColor.whiteColor()
        datePickerView.setValue(UIColor.darkGrayColor(), forKey: "textColor")
        datePickerView.layer.borderColor = UIColor.darkGrayColor().CGColor
        datePickerView.layer.borderWidth = 0.5
        datePickerView.layer.cornerRadius = 4.0
        datePickerView.addTarget(self, action: valuechangeSelector, forControlEvents: UIControlEvents.ValueChanged)
        
        inputView.addSubview(datePickerView)
        
        // for doneButton
        let doneButton = UIButton(frame: CGRectMake(0, 0, inputView.frame.size.width, 40.0))
        doneButton.setTitle(doneTitle, forState: UIControlState.Normal)
        doneButton.setTitle(doneTitle, forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        doneButton.backgroundColor = GreenTheme
        inputView.addSubview(doneButton)
        doneButton.addTarget(self, action: doneSelector, forControlEvents: UIControlEvents.TouchUpInside)
        
        // assign textfield's inputView
        sender.inputView = inputView
        
    }
    
    func convertPickerToDateTimeType() -> UIDatePickerMode {
        
        if pickerType == .Time
        {
            return UIDatePickerMode.Time
        }
        
        return .Date
    }

}
