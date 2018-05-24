//
//  UserInfo.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 5/12/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import Foundation
import UIKit


struct UserInfo: Decodable {
    let userId: String
    let email: String
    let username: String
    let password: String
    let name: String
    let initial: String
    let lastname: String
    let birthday: String
    let phoneNumber: String
    let photo: String
    
    init(json: [String: Any]) {
        userId = json["userId"] as? String ?? ""
        email = json["email"] as? String ?? ""
        username = json["username"] as? String ?? ""
        password = json["password"] as? String ?? ""
        name = json["name"] as? String ?? ""
        initial = json["initial"] as? String ?? ""
        lastname = json["lastname"] as? String ?? ""
        birthday = json["birthday"] as? String ?? ""
        phoneNumber = json["phoneNumber"] as? String ?? ""
        photo = json["photo"] as? String ?? ""
    }
}

class User {
    
    func getUserInfo() {
        
        //url to get the data that is in the database
        let jsonUrlString = "http://localhost/dcomida/api/user.php"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let users = try JSONDecoder().decode([UserInfo].self, from: data)
                
                for user in users {
                    print(user)
                }
                
            } catch let jsonError {
                print("Error serializing json: \(jsonError)")
            }
        }.resume()
    }
    
    func getUser(username: String, password: String){
        var info = [UserInfo]()
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/dcomida/api/user.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(username)&password=\(password)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let users = try JSONDecoder().decode([UserInfo].self, from: data)
                
                info = users
                print("From info \(info)")
            } catch let jsonError {
                print("Error serializing json: \(jsonError)")
            }
            }.resume()
    }
}
