//
//  DetailController.swift
//  2.
//
//  Created by Hanh Vo on 10/12/16.
//  Copyright © 2016 Hanh Vo. All rights reserved.
//

import UIKit

enum ScreenType: String{
    case None = ""
    case Red = "A"
    case Green = "B"
    case Blue = "C"
}

protocol DetailDelegate {
    
    func backToSupperView(screenInfo: (ScreenType,UIColor));
}

class DetailController: UIViewController {
    
    // MARK: - UI
    @IBOutlet weak var colorButton: UIButton!
    
    // MARK: - Properties
    var screenInfo: (ScreenType,UIColor) = (.None, .white)
    var delegate:DetailDelegate?

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure for beginning
        configureForBeginning()
    }
    
    // MARK: - Actions
    @IBAction func colorButtonTapped(_ sender: AnyObject) {
        
        // Send back data to super
        delegate?.backToSupperView(screenInfo: screenInfo)
        
        // Pop to maincontroller
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Internal methods
    private func configureForBeginning() {
        
        // Custom Navigation
        self.title = screenInfo.0.rawValue
        self.navigationItem.hidesBackButton = true
        
        // colorButton
        colorButton.backgroundColor = screenInfo.1
    }

}
