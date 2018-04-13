//
//  LoginController.swift
//  Bookiie
//
//  Created by HanhVo on 5/16/16.
//  Copyright © 2016 HanhVo. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var withoutButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

        // Do any additional setup after loading the view.
    }

    // MARK: - Method
    func configureUI()  {
        
        // emailTextField
        emailTextField.backgroundColor = UIColor.whiteColor()
        emailTextField.textColor = UIColor.darkGrayColor()
        emailTextField.layer.borderColor = GreenTheme.CGColor
        emailTextField.layer.cornerRadius = 16.0
        emailTextField.layer.borderWidth = 0.5
        emailTextField.setLeftIcon("email")

        // passwordTextField
        passwordTextField.backgroundColor = UIColor.whiteColor()
        passwordTextField.textColor = UIColor.darkGrayColor()
        passwordTextField.layer.borderColor = GreenTheme.CGColor
        passwordTextField.layer.cornerRadius = 16.0
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.secureTextEntry = true
        passwordTextField.setLeftIcon("password")
        
        // facebookButton
        facebookButton.layer.cornerRadius = 16.0
        facebookButton.layer.borderColor = BlueTheme.CGColor
        facebookButton.layer.borderWidth = 0.5
        facebookButton.titleLabel?.textColor = BlueTheme
        
        // loginButton
        loginButton.layer.cornerRadius = 16.0
        loginButton.layer.borderColor = SalmonTheme.CGColor
        loginButton.layer.borderWidth = 0.5
        loginButton.setTitleColor(SalmonTheme, forState: .Normal)
    }

}
