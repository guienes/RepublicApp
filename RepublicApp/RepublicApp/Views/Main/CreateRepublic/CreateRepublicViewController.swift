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
    
    func create() {
        var success = false
        let group = DispatchGroup() // initialize the async
        var called = false
        group.enter()
         let (valid, message) = model.validateFields(republicname: repNameTextField.text, acesspassword: passwordTextField.text, confirmacesspassword: confirmPassTextField.text)
        if valid {
            self.showSpinner(onView: self.view)

            createRepublic(name: self.repNameTextField.text!, password: passwordTextField.text!, picture: "teste", members: UserDefaults.standard.string(forKey: USER_ID) ?? "") { (result, error) in
                if !called {
                    if result?.values.first as! Int == 1 {
                        called = true
                        success = true
                        group.leave()
                    } else {
                        self.removeSpinner()
                        self.showErrorAlert(title: "Erro", message: "Requisição Falhou")
                    }
                }
            }
        } else {
            self.errorLabel.isHidden = false
            self.errorLabel.text = message
        }
        
        group.notify(queue: .main) {
            self.removeSpinner()
            //            let check = response["result"] as? String
            if success == true {
                UserDefaults.standard.set(self.repNameTextField.text, forKey: REPUBLIC_NAME)
                self.performSegue(withIdentifier: "createRepublicSegue", sender: self)
            } else {
                //error
            }
        }
    }
    
    @IBAction func createTap(_ sender: Any) {
        create()
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
