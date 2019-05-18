//
//  File.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation

class User {
    var name: String?
    var id: String?
    var email: String?
    var password: String?
    var phone: String?
    var pic: String?
}

//SignUp Request
func signUp(name: String, email: String, password: String, phone: String, picture: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let parameters = ["name": name, "email": email, "password": password, "phone": phone, "picture": "teste"]
    //create the url with NSURL
    let url = URL(string: "https://republicanapp.herokuapp.com/api/signup/")!
    
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


//Login Request
func login(email: String, password: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let parameters = ["email": email, "password": password]
    //create the url with NSURL
    let url = URL(string: "https://republicanapp.herokuapp.com/api/login/")!
    
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
                        let user = User()
                        user.name = json["name"] as! String
                        user.id = json["_id"] as! String
                        user.email = json["email"] as! String
                        user.password = json["password"] as! String
                        user.phone = json["phone"] as! String
                        
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(user.name, forKey: USER_NAME)
                        userDefaults.set(user.id, forKey: USER_ID)
                        userDefaults.set(user.email, forKey: USER_EMAIL)
                        userDefaults.set(user.password, forKey: USER_PASSWORD)
                        userDefaults.set(user.phone, forKey: USER_PHONE)
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
