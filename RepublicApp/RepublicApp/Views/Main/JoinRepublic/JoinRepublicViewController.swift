//
//  JoinRepublicViewController.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 09/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit

class JoinRepublicViewController: UIViewController {

    @IBOutlet weak var republicIDTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var republicPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let model = JoinRepublic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoScrollWhenKeyboardShowsUp()
        // Do this for each UITextField
        republicIDTextField.delegate = self
        republicIDTextField.tag = 1 //Increment accordingly
        republicPasswordTextField.delegate = self
        republicPasswordTextField.tag = 2
        
    }
    
    // MARK:- Scroll View Content Inset
    override func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        scrollView.contentInset = inset
    }
    
    func join() {
        var response: [String : Any]?
        let group = DispatchGroup() // initialize the async
        var called = false
        group.enter()
        let(valid,message) = model.validateFields(republicID: republicIDTextField.text, republicPassword: republicPasswordTextField.text)
        if valid {
            joinRepublic(idRepublic: republicIDTextField.text!, idUser: UserDefaults.standard.string(forKey: USER_ID) ?? "", password: republicPasswordTextField.text!) { (result, error) in
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
                UserDefaults.standard.set(self.republicIDTextField.text, forKey: REPUBLIC_ID)
                self.performSegue(withIdentifier: "joinRepublicSegue", sender: self)
            } else {
                //error
            }
        }
    }
    
    @IBAction func enterTap(_ sender: Any) {
        join()
    }
}

extension JoinRepublicViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == republicIDTextField {
            republicPasswordTextField.becomeFirstResponder()
        } else {
            republicPasswordTextField.resignFirstResponder()
        }

        // Try to find next responder
//        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//        } else {
//            // Not found, so remove keyboard.
//            textField.resignFirstResponder()
//        }
        // Do not add a line break
        return false
    }
    
}

//            let (valid,message) = model.validateFields(email: emailTextField.text, password: passwordTextField.text) //valid é o bool, e message é a mensagem que aparece meu bom!

