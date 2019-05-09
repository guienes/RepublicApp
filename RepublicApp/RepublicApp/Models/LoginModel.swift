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
    
    func validateFields(email: String?, password: String?) -> Bool{
        if let email = email, isValidEmail(testStr: email), let password = password, isPasswordValid(password: password) {
            return true
        }
        return false
    }
}
