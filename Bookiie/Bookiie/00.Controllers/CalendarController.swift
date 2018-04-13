//
//  CalendarController.swift
//  Bookiie
//
//  Created by HanhVo on 5/14/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

import CalendarView
import SwiftMoment

class CalendarController: UIViewController {
    
    
    @IBOutlet weak var calendar: CalendarView!
    
    var date: Moment! {
        didSet {
            title = date.format("MMMM d, yyyy")
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        configureUI();
    }
    
    func configureUI() {
        
        // CalendarView
        date = moment()
        calendar.delegate = self
        
        CalendarView.daySelectedBackgroundColor = SalmonTheme
        CalendarView.daySelectedTextColor = UIColor.whiteColor()
        CalendarView.todayBackgroundColor = GreenTheme
        CalendarView.todayTextColor = UIColor.whiteColor()
        CalendarView.otherMonthBackgroundColor = UIColor.clearColor()
        CalendarView.otherMonthTextColor = UIColor.whiteColor()
        CalendarView.dayTextColor = UIColor.whiteColor()
        CalendarView.dayBackgroundColor = UIColor.clearColor()
        CalendarView.weekLabelTextColor = UIColor.whiteColor()
        
        
        // for self
        view.backgroundColor = MenuTheme

    }
    
}

extension CalendarController: CalendarViewDelegate {
    
    func calendarDidSelectDate(date: Moment) {
        self.date = date
    }
    
    func calendarDidPageToDate(date: Moment) {
        self.date = date
    }
    
}
