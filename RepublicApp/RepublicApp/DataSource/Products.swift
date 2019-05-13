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
    var quantity: Int?
    var isComum: Bool?
    var isRecorrente: Bool?
    var isListBuy: Bool?
//    var designation: //mudar de string para userr
//    var republic: //Mudar para republic
}


func getDishes(_ url: String, completion: @escaping (Product?, Error?) -> Void) {
    do {
        if let file = URL(string: url) {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                
                print(object)
                
            } else if let object = json as? [Any] {
                for anItem in object as! [Dictionary<String, AnyObject>] {
                    if ((anItem["name"] != nil) && (anItem["_id"] != nil)){
                        
                        let name = anItem["name"] as! String
                        let price = anItem["price"] as! String
                        let id = anItem["_id"] as! String
                        
                        let image = anItem["image"] as! String
                        let comment = anItem["comment"] as! String
                        let type = anItem["type"] as! String
                        let ingredients = anItem["ingredients"] as! String
                        
//                        let dish = Dish(name, price, id, 0, image, comment, type, ingredients)
                        //                        (dishName, dishPrice, dishID, 0)
                        
//                        dish.create()
                    }
                }
//                completion(nil, nil)
            } else {
                print("JSON is invalid")
                completion(nil, nil)
            }
        } else {
            print("no file")
            completion(nil, nil)
        }
    } catch {
        print(error.localizedDescription)
    }
}
