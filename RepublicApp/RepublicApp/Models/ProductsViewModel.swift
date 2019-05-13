//
//  ProductsViewModel.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewModel {

    var products = [Product]()
    var despensaComumProducts = [Product]()
    var despensaMinhaProducts = [Product]()
    var listaComumProducts = [Product]()
    var listaMinhaProducts = [Product]()
    
    func filterData(){
            for product in products {
                if let isComum = product.isComum, let isList = product.isListBuy {
                    if isComum {
                        if !isList {
                            despensaComumProducts.append(product)
                        } else {
                            listaComumProducts.append(product)
                        }
                    } else {
                        if !isList {
                            despensaMinhaProducts.append(product)
                        } else {
                            listaMinhaProducts.append(product)
                        }
                    }
                }
            }
        
    }
    
    func getNumberOfRows(tableViewIndex: Int) -> Int {
        switch tableViewIndex {
        case 1:
            return despensaComumProducts.count
        case 2:
            return despensaMinhaProducts.count
        case 3:
            return listaComumProducts.count
        case 4:
            return listaMinhaProducts.count
        default:
            return 0
        }
    }
    
    func getCellForRow(index: Int, tableViewIndex: Int) -> Product {
        switch tableViewIndex {
        case 1:
            return despensaComumProducts[index]
        case 2:
            return despensaMinhaProducts[index]
        case 3:
            return listaComumProducts[index]
        case 4:
            return listaMinhaProducts[index]
        default:
            return Product()
        }
    }
    
    
}
