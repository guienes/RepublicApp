//
//  File.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 13/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation


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
            
            if let file = URL(string: "http://example.test/colours") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                
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

