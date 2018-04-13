//
//  ContentViewController.swift
//  Bookiie
//
//  Created by HanhVo on 5/13/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit


class BookingController: UIViewController, AHPickerDelegate {
    
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    @IBOutlet weak var tfNumberOfPeople: UITextField!
    @IBOutlet weak var btnEating: UIButton!
    
    var numberPeoplePicker:AHPicker?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        configureUI()
    }
    
    // MARK: Actions
    @IBAction func dateTextFieldEditing(sender: UITextField) {
        
        let datePicker = AHDateTimePicker()
        datePicker.frame = CGRect(origin: view.center, size: CGSize(width: view.frame.width, height: view.frame.width * 2/3))
        datePicker.pickerType = .Date
        datePicker.showDateTimePicker(sender, doneSelector: #selector(datedoneButton), valuechangeSelector: #selector(datePickerValueChanged))
        
    }
    
    @IBAction func timeTextFieldEditing(sender: UITextField) {
       
        let datePicker = AHDateTimePicker()
        datePicker.frame = CGRect(origin: view.center, size: CGSize(width: view.frame.width, height: view.frame.width * 2/3))
        datePicker.pickerType = .Time
        datePicker.showDateTimePicker(sender, doneSelector: #selector(timeDoneButton), valuechangeSelector: #selector(timePickerValueChanged))
        
    }
    
    @IBAction func numberPeoplePickerTextFieldEditing(sender: UITextField) {
        
        let dataList = ["1 người", "2 người", "3 người", "4 người", "5 người", "6 người", "7 người", "8 người", "9 người", "10 người"]
        let frame = CGRect(origin: view.center, size: CGSize(width: view.frame.width, height: view.frame.width * 2/3))
        numberPeoplePicker = AHPicker()
        numberPeoplePicker!.initPicker(dataList, iFrame: frame, iPickerType: .NumberOfPeople)
        numberPeoplePicker!.showPicker(sender)
        numberPeoplePicker!.delegate = self
    }
    @IBAction func backTapped(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func eatingWithEase(sender: AnyObject) {
        
        let storyBoardName: NSString = Common.storyBoardName(.BookedDetail)
        let content = storyboard!.instantiateViewControllerWithIdentifier(storyBoardName as String) as! BookedDetailController
        presentViewController(content, animated: true, completion: nil)
    }
    
    // MARK: - Booking's Methos
    func configureUI()  {
        
        // for btnEating
        btnEating.layer.cornerRadius = 4.0
        
        // tfDate
        tfDate.setLeftIcon(BookiieTextField.Date.rawValue)
        tfDate.textColor  = UIColor.darkGrayColor()
        
        // tfTime
        tfTime.setLeftIcon(BookiieTextField.Time.rawValue)
        tfTime.textColor  = UIColor.darkGrayColor()
        
        // tfNumberOfPeople
        tfNumberOfPeople.setLeftIcon(BookiieTextField.NumberPeople.rawValue)
        tfNumberOfPeople.textColor  = UIColor.darkGrayColor()

    }
    
    //MARK: AHDateTimePicker
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        tfDate.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func datedoneButton()
    {
        tfDate.resignFirstResponder()
    }
    
    func timePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        tfTime.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func timeDoneButton()
    {
        tfTime.resignFirstResponder()
    }
    
    //MARK: AHPickerDelegate
    func ahPickerSelected(sender:AHPicker,content:String) {
        
        tfNumberOfPeople.text = content
    }
    
    
    func ahPickerDoneTapped(sender:AHPicker) {
        
        tfNumberOfPeople.resignFirstResponder()
    }

}
