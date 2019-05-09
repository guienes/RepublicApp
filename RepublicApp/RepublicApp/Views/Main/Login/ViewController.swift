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
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    let model = LoginModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationController()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "loginSegue" {
            let (valid,message) = model.validateFields(email: emailTextField.text, password: passwordTextField.text) //valid é o bool, e message é a mensagem que aparece meu bom!
            if !valid {
                self.errorLabel.isHidden = false
            }
            return valid
        }
        return true
    }


}

