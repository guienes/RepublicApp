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

func getProducts(idRepublic: String, completion: @escaping (Bool?, Error?, [Product]?) -> Void) {
    do {
        if let file = URL(string: "https://republicanapp.herokuapp.com/api/products/\(idRepublic)/") {
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
                        let isRecorrente = anItem["isRecorrent"] as! Bool
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

func deleteProducts(idProduct: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let parameters = ["idProduct": idProduct, "idRepublic": UserDefaults.standard.string(forKey: REPUBLIC_ID)]
    //create the url with NSURL
    let url = URL(string: "https://republicanapp.herokuapp.com/api/deleteProduct/")!
    
    //create the session object
    let session = URLSession.shared
    
    //now create the Request object using the url object
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST" //set http method as POST
    do {
        
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
    } catch let error {
        print(error.localizedDescription)
        completion(nil, error)
    }
    
    //HTTP Headers
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Acadresst")
    
    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        
        
        guard error == nil else {
            completion(nil, error)
            return
        }
        
        guard data != nil else {
            completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
            return
        }
        
        do {
            
            print(data)
            if let file = data {
                let json = try JSONSerialization.jsonObject(with: file, options: []) as! [String:Any]
                print(json)
                for (key, value) in json { //key é o parametro e value o valor
                    if (key == "result"){
                        if(value as? Int == 0){
                            completion(nil, error)
                        } else {
                            completion(nil, error)
                        }
                    } else {
                        completion(json, nil)
                    }
                }
                
            } else {
                
                print("no file")
                
            }
            
        } catch {
            print(error.localizedDescription)
            
        }
    })
    
    task.resume()
    
}

//Login Request
func postProduct(product: Product, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let parameters = ["name": product.name, "quantity": product.quantity, "isComum": product.isComum ?? false, "isRecorrent": product.isRecorrente ?? false, "isListBuy": product.isListBuy, "designation": product.designation, "republic": product.republic] as [String : Any]
    //create the url with NSURL
    let url = URL(string: "https://republicanapp.herokuapp.com/api/createProduct/")!
    
    //create the session object
    let session = URLSession.shared
    
    //now create the Request object using the url object
    var request = URLRequest(url: url)
    
    request.httpMethod = "POST" //set http method as POST
    do {
        
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
    } catch let error {
        print(error.localizedDescription)
        completion(nil, error)
    }
    
    //HTTP Headers
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Acadresst")
    
    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request, completionHandler: { data, response, error in
        
        
        guard error == nil else {
            completion(nil, error)
            return
        }
        
        guard data != nil else {
            completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
            return
        }
        
        do {
            
            print(data)
            if let file = data {
                let json = try JSONSerialization.jsonObject(with: file, options: []) as! [String:Any]
                print(json)
                for (key, value) in json { //key é o parametro e value o valor
                    if (key == "result"){
                        if(value as? Int == 0){
                            completion(nil, error)
                        } else {
                            completion(nil, error)
                        }
                    } else {
                        completion(json, nil)
                    }
                }
                
            } else {
                
                print("no file")
                
            }
            
        } catch {
            print(error.localizedDescription)
            
        }
    })
    
    task.resume()
    
}
