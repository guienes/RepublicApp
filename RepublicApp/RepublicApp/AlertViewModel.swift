//
//  AlertViewModel.swift
//  RepublicApp
//
//  Created by Guilherme Enes on 14/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//
//





import Foundation
import UIKit

extension UIViewController {        //irá mostrar um aviso na tela

    func showErrorAlert(title: String, message: String) {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        
        self.present(alert, animated: true)

    }


}

