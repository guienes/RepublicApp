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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoScrollWhenKeyboardShowsUp()
    }
    
    // MARK:- Scroll View Content Inset
    override func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        scrollView.contentInset = inset
    }
    

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "CreationSegue" {
            let (valid, message) = model.validateFields(nome: createNameTextField.text, telephone: Telephone.text, confirmpassword: confirmPass.text, email: Telephone.text, password: CreatePassword.text)
            
            
            //            let (valid,message) = model.validateFields(email: emailTextField.text, password: passwordTextField.text) //valid é o bool, e message é a mensagem que aparece meu bom!
            if !valid {
                self.errorLabel.isHidden = false
                self.errorLabel.text = message
            }
            return valid
        }
        return true
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
