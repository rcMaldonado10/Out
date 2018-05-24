//
//  LoginViewController.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 4/21/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginCard: UIImageView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let user = User() // user hereda de la clase User
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        user.getUserInfo()

        loginCard.layer.cornerRadius = 10.0
        loginCard.clipsToBounds = true
        
        usernameTextfield.layer.borderColor = UIColor.black.cgColor
        usernameTextfield.layer.borderWidth = 1.0
        usernameTextfield.layer.cornerRadius = 5.0
        usernameTextfield.borderStyle = .roundedRect

        passwordTextfield.layer.borderColor = UIColor.black.cgColor
        passwordTextfield.layer.borderWidth = 1.0
        passwordTextfield.layer.cornerRadius = 5.0
        passwordTextfield.borderStyle = .roundedRect
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        
        let title = "Lo Sentimos"
        let message = "Los credenciales entrados no son validos. Verifique que sean los credenciales correctos"
        
//        user.getUser(username: usernameTextfield.text!, password: passwordTextfield.text!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/dcomida/api/user.php")! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(usernameTextfield.text!)&password=\(passwordTextfield.text!)"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let users = try JSONDecoder().decode([UserInfo].self, from: data)
                
                if users.count > 0 {
                    print("Es \(users.count)")
                } else {
                    print("Es \(users.count)")
                }
            } catch let jsonError {
                print("Error serializing json: \(jsonError)")
            }
            
            }.resume()
    }
}
