//
//  CreateRepublicViewController.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 09/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

class CreateRepublicViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var repNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let model = CreateRepublic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoScrollWhenKeyboardShowsUp()
        
        repNameTextField.delegate = self
        repNameTextField.tag = 1 //Increment accordingly
        passwordTextField.delegate = self
        passwordTextField.tag = 2
        confirmPassTextField.delegate = self
        confirmPassTextField.tag = 3
    }
    
    // MARK:- Scroll View Content Inset
    override func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        scrollView.contentInset = inset
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "CreateRepublic" {
            let (valid, message) = model.validateFields(republicname: repNameTextField.text, acesspassword: passwordTextField.text, confirmacesspassword: confirmPassTextField.text)
            
            //            let (valid,message) = model.validateFields(email: emailTextField.text, password: passwordTextField.text) //valid é o bool, e message é a mensagem que aparece meu bom!
            if !valid {
                self.errorLabel.text = message
                self.errorLabel.isHidden = false
            }
            return valid
        }
        return true
    }
}

extension CreateRepublicViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //clica em return, vai pra p
        if textField == repNameTextField{
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPassTextField.becomeFirstResponder()
        } else {
            confirmPassTextField.resignFirstResponder()
        }
        return false
    }
}
