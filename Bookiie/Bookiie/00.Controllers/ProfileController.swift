//
//  ProfileController.swift
//  Bookiie
//
//  Created by HanhVo on 5/14/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI ()
    }

    // MARK: - Method
    func configureUI()  {
        
        // tfEmail
        tfEmail.backgroundColor = UIColor.whiteColor()
        tfEmail.textColor = UIColor.darkGrayColor()
        tfEmail.layer.borderColor = UIColor.darkGrayColor().CGColor
        tfEmail.layer.cornerRadius = 4.0
        tfEmail.layer.borderWidth = 0.5
        
        // passwordTextField
        tfPassword.textColor = UIColor.whiteColor()
        tfPassword.textColor = UIColor.darkGrayColor()
        tfPassword.layer.borderColor = UIColor.darkGrayColor().CGColor
        tfPassword.layer.cornerRadius = 4.0
        tfPassword.layer.borderWidth = 0.5
        tfPassword.secureTextEntry = true
        
        // passwordTextField
        tfPhone.backgroundColor = UIColor.whiteColor()
        tfPhone.layer.borderColor = UIColor.darkGrayColor().CGColor
        tfPhone.layer.cornerRadius = 4.0
        tfPhone.layer.borderWidth = 0.5
        tfPhone.keyboardType = .PhonePad
        
        // loginButton
        saveButton.layer.cornerRadius = 16.0
        saveButton.layer.borderColor = GreenTheme.CGColor
        saveButton.layer.borderWidth = 0.5
        saveButton.setTitleColor(GreenTheme, forState: .Normal)
    }
}
