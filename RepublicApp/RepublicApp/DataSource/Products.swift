//
//  Products.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation

class Products {
    var result: [Product]?
}

class Product {
    var name: String?
    var id: String?
    var quantity: Int?
    var isComum: Bool?
    var isRecorrente: Bool?
    var isListBuy: Bool?
    var designation: String? //mudar de string para userr
    var republic: String?//id
}

func getProducts(idProduct: String, completion: @escaping (Bool?, Error?, [Product]?) -> Void) {
    do {
        if let file = URL(string: "https://republicanapp.herokuapp.com/api/product/\(idProduct)/") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                
                print(object)
                
            } else if let object = json as? [Any] {
                var products = [Product]()
                for anItem in object as! [Dictionary<String, AnyObject>] {
                    if ((anItem["name"] != nil) && (anItem["_id"] != nil)){
                        
                        let name = anItem["name"] as! String
                        let quantity = anItem["quantity"] as! Int
                        let id = anItem["_id"] as! String
                        
                        let isComum = anItem["isComum"] as! Bool
                        let isRecorrente = anItem["isRecorrente"] as! Bool
                        let isListBuy = anItem["isListBuy"] as! Bool
                        let designation = anItem["designation"] as! String
                        let republic = anItem["republic"] as! String

                        let product = Product()
                        product.quantity = quantity
                        product.name = name
                        product.id = id
                        product.isComum = isComum
                        product.isRecorrente = isRecorrente
                        product.isListBuy = isListBuy
                        product.designation = designation
                        product.republic = republic

                        //                        let dish = Dish(name, price, id, 0, image, comment, type, ingredients)
                        //                        (dishName, dishPrice, dishID, 0)
                        products.append(product)
                    }
                }
                completion(true, nil, products)
            } else {
                print("JSON is invalid")
                completion(false, nil, nil)
            }
        } else {
            print("no file")
            completion(false, nil, nil)
        }
    } catch {
        print(error.localizedDescription)
    }
}
