//
//  ProductView.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ProductView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    func setupShadows() {
        layer.masksToBounds = false
        let shadowColor = UIColor(red: 138/255.0, green: 80/255.0, blue: 130/255.0, alpha: 0.35)
        layer.shadowColor =  shadowColor.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 6
//        layer.shouldRasterize = true
    }
}


