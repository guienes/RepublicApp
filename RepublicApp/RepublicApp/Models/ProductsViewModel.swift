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
    
    var requestNewProduct = Product()
    var addIsComum: Bool?
    var addIsList: Bool?
    
    var isConstant = true
    var quantity = 1
    
    func setupMock() {
        let product = Product()
        product.name = "Paçoca"
        product.quantity = 2
        product.isComum = true
        product.isListBuy = false
        products.append(product)
        
        let product2 = Product()
        product2.name = "Abacaxi"
        product2.quantity = 2
        product2.isComum = false
        product2.isListBuy = false
        products.append(product2)
        
        let product3 = Product()
        product3.name = "Bolacha"
        product3.quantity = 2
        product3.isComum = true
        product3.isListBuy = true
        products.append(product3)
        
        let product4 = Product()
        product4.name = "Morango"
        product4.quantity = 2
        product4.isComum = false
        product4.isListBuy = true
        products.append(product4)
        
        filterData()
    }
    
    
    func filterData(){
        despensaComumProducts.removeAll()
        despensaMinhaProducts.removeAll()
        listaComumProducts.removeAll()
        listaMinhaProducts.removeAll()
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
        products.removeAll()
        
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
    
    func addQtd() -> Int {
        self.quantity += 1
        return quantity
    }
    
    func lessQtd() -> Int {
        if quantity <= 1 {
            return 1
        }
        self.quantity -= 1
        return quantity
    }
    
    func getProductFromId(id: String) -> Product {
        for product in despensaComumProducts {
            if id == product.id {
                return product
            }
        }
        for product in despensaMinhaProducts {
            if id == product.id {
                return product
            }
        }
        for product in listaComumProducts {
            if id == product.id {
                return product
            }
        }
        for product in listaMinhaProducts {
            if id == product.id {
                return product
            }
        }
        return Product()
    }
}
