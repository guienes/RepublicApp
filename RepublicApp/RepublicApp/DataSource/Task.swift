//
//  Task.swift
//  RepublicApp
//
//  Created by Felipe Kaça Petersen on 16/05/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation

class Tasks {
    var tasks: [Task]?
}

class Task {
    var name: String?
    var id: String?
    var desc: String?
    var isRecorrent: Bool?
    var designation: String?
    var republic: String?
}


func getTasks(idRepublic: String, completion: @escaping (Bool?, Error?, [Task]?) -> Void) {
    do {
        if let file = URL(string: "https://republicanapp.herokuapp.com/api/tasks/\(idRepublic)/") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
//                for (key, value) in object {
////                    print(value)
//                    if let object2 = value as? [String: Any] {
//                        for (key2, value2) in object2 {
////                            print(value)
//                        }
//                    }
////                    for (key2, value2) in value {
////                        if key2
////                    }
//                }
                print(object)
                
            } else if let object = json as? [Any] {
                var tasks = [Task]()
                for anItem in object as! [Dictionary<String, AnyObject>] {
                    if ((anItem["name"] != nil) && (anItem["_id"] != nil)){
                        
                        let name = anItem["name"] as! String
                        let desc = anItem["desc"] as! String
                        let id = anItem["_id"] as! String
                        let isRecorrente = anItem["isRecorrent"] as! Bool
                        let designation = anItem["designation"] as? String ?? ""
                        let republic = anItem["republic"] as! String
                        
                        let task = Task()
                        task.desc = desc
                        task.name = name
                        task.id = id
                        task.isRecorrent = isRecorrente
                        task.designation = designation
                        task.republic = republic
                        
                        //                        let dish = Dish(name, price, id, 0, image, comment, type, ingredients)
                        //                        (dishName, dishPrice, dishID, 0)
                        tasks.append(task)
                    }
                }
                completion(true, nil, tasks)
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

func deleteTask(idProduct: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let parameters = ["idTask": idProduct, "idRepublic": UserDefaults.standard.string(forKey: REPUBLIC_ID)]
    //create the url with NSURL
    let url = URL(string: "https://republicanapp.herokuapp.com/api/deleteTask/")!
    
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
                            completion(json, error)
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
func postTask(task: Task, completion: @escaping ([String: Any]?, Error?) -> Void) {
    let parameters = ["name": task.name, "desc": task.desc, "isRecorrent": task.isRecorrent ?? false, "designation": task.designation, "republic": task.republic] as [String : Any]
    //create the url with NSURL
    let url = URL(string: "https://republicanapp.herokuapp.com/api/createTask/")!
    
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
                            completion(json, error)
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
