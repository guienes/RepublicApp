//
//  CreateAccountViewController.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 09/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var createNameTextField: UITextField!
    @IBOutlet weak var CreateEmail: UITextField!
    @IBOutlet weak var Telephone: UITextField!
    @IBOutlet weak var CreatePassword:UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var errorLabel: UILabel!
    
    let model = AccoountCreationModel()
    var called = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoScrollWhenKeyboardShowsUp()
    }
    
    // MARK:- Scroll View Content Inset
    override func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        scrollView.contentInset = inset
    }
    
    @IBAction func didTapCreate(_ sender: Any) {
        self.createAccount()
    }
    
    func createAccount() {
        var response: [String : Any]?
        let group = DispatchGroup()
        group.enter()
// initialize the async
        let (valid, message) = model.validateFields(nome: createNameTextField.text, telephone: Telephone.text, confirmpassword: confirmPass.text, email: Telephone.text, password: CreatePassword.text)
        if valid {
            signUp(name: createNameTextField.text!, email: CreateEmail.text!, password: CreatePassword.text!, phone: Telephone.text!, picture: "teste") { (result, error) in
                if !self.called {
                    if let re = result {
                        response = re
                        self.called = true
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
            
                self.performSegue(withIdentifier: "unwindToLogin", sender: self)
            } else {
                //error
            }
        }
        
    }

}

extension CreateAccountViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == createNameTextField {
            CreateEmail.becomeFirstResponder()
        } else if textField == CreateEmail{
            Telephone.becomeFirstResponder()
        } else if textField == Telephone {
            CreatePassword.becomeFirstResponder()
        } else if textField == CreatePassword {
            confirmPass.becomeFirstResponder()
        } else {
            confirmPass.resignFirstResponder()
        }
        return false
    }
}
