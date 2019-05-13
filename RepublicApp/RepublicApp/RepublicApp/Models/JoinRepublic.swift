//
//  JoinRepublic.swift
//  RepublicApp
//
//  Created by Guilherme Enes on 10/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class JoinRepublic: UIViewController{
    func validateFields(republicID: String?, republicPassword: String?) -> (Bool,String) {
        if let republicID = republicID, republicID.isEmpty == false {
            if let republicPassword = republicPassword{
                return (true,"")
            } else {
                return (false, "Insira senha")
            }
        } else {
            return (false, "insira ID")
        }
    }
}
