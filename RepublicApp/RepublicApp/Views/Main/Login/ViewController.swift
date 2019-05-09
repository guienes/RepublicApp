//
//  ViewController.swift
//  RepublicApp
//
//  Created by Guilherme Enes on 07/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let model = LoginModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationController()
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            return model.validateFields(email: emailTextField.text, password: passwordTextField.text)
        }
        return true
    }


}

