//
//  LoginModel.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 09/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class LoginModel : UIViewController {
    
    func validateFields(email: String?, password: String?) -> (Bool,String){
        if let email = email, isValidEmail(testStr: email){
            if let password = password, isPasswordValid(password: password){
                return (true,"")
            } else {
                return (false,"Senha incorreta")
            }
        } else {
            return(false,"Email incorreto")
        }

    }
}
