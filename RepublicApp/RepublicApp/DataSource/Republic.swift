
//
//  Republic.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 14/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation

func createRepublic(name: String, password: String, picture: String, members: String,  completion: @escaping ([String: Any]?, Error?) -> Void) {
    let parameters = ["name": name, "members": members, "password": password, "picture": "teste"]
    //create the url with NSURL
    let url = URL(string: "https://republicanapp.herokuapp.com/api/createRepublic/")!
    
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
                //TODO:- Salvar o id da republica
                for (key, value) in json {
                    if key == "result" {
                        UserDefaults.standard.set(value, forKey: REPUBLIC_ID)
                        completion(json, nil)
                    }
                }
                
            } else {
                completion(nil, nil)
                print("no file")
                
            }
            
        } catch {
            print(error.localizedDescription)
            
        }
    })
    
    task.resume()
    
}


func joinRepublic(idRepublic: String, idUser: String, password: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let parameters = ["idRepublic": idRepublic, "idUser": idUser, "password": password]
    //create the url with NSURL
    let url = URL(string: "https://republicanapp.herokuapp.com/api/joinRepublic/")!
    
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
                for (key, value) in json {
                    if (key == "result"){
                        if(value as? Int == 0){
                            completion(nil, nil)
                        } else {
                            completion(json, nil)
                        }
                    } else {
                        completion(nil, nil)
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

func getMembers(republicId: String, completion: @escaping (Bool?, Error?, [User]?) -> Void) {
    do {
        if let file = URL(string: "https://republicanapp.herokuapp.com/api/republicMembers/\(republicId)/") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                
                print(object)
                
            } else if let object = json as? [Any] {
                var users = [User]()
                for anItem in object as! [Dictionary<String, AnyObject>] {
                    if ((anItem["name"] != nil) && (anItem["_id"] != nil)){
                        
                        
                        
                        let name = anItem["name"] as! String
                        let email = anItem["email"] as! String
                        let id = anItem["_id"] as! String
                        
                        let phone = anItem["phone"] as! String
                        let password = anItem["password"] as! String
                        
                        let user = User()
                        user.email = email
                        user.name = name
                        user.id = id
                        user.phone = phone
                        user.password = password
//                        let dish = Dish(name, price, id, 0, image, comment, type, ingredients)
                        //                        (dishName, dishPrice, dishID, 0)
                        users.append(user)
                    }
                }
                completion(true, nil, users)
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
