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
    
    @IBAction func didTapNext(_ sender: Any) {
        postLogin()
//        self.performSegue(withIdentifier: "republicSegue", sender: self)

    }

    func postLogin() {
        var response: [String : Any]?
        let group = DispatchGroup() // initialize the async
        var called = false
        group.enter()
        let (valid,message) = model.validateFields(email: emailTextField.text, password: passwordTextField.text) //valid é o bool, e message é a mensagem que aparece meu bom!
        if valid {
            login(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "") { (result, error) in
                if !called {
                    if let re = result {
                        response = re
                        called = true
                        group.leave()
                        
                    }
                }
            }
        } else {
            self.errorLabel.isHidden = false
            self.errorLabel.text = message
        }
        
        group.notify(queue: .main) {
//            let check = response["result"] as? String
            if let response = response {
                self.performSegue(withIdentifier: "republicSegue", sender: self)
            } else {
                //error
            }
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return false
    }
}

