//
//  AccountCreation.swift
//  RepublicApp
//
//  Created by Guilherme Enes on 09/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class AccoountCreationModel : UIViewController {
    
    func validateFields(nome: String?,telephone: String?, confirmpassword:String?, email: String?, password: String?) -> (Bool,String){
        if let nome = nome, nome.isEmpty == false{
            if let email = email, isValidEmail(testStr: email){
                if let telephone = telephone{
                    if let password = password, isPasswordValid(password: password){
                        if let confirmpassword = confirmpassword, password == confirmpassword{
                            return (true,"")
                        } else{
                            return (false,"As senhas diferem")
                        }
                    } else {
                        return (false, "Senha precisa ter 6 digitos no minimo")
                    }
                } else {
                    return (false, "Preencha o campo")
                }
            } else {
                return (false, "Email inválido")
            }
        } else {
            return (false, "Coloque algum nome")
        }

    }
}
