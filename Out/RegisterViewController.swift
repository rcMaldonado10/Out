//
//  RegisterViewController.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 5/13/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = "Coco Rodriguez"
        usernameTextField.text = "coco"
        emailTextField.text = "rcm1234@admin.admin"
        passwordTextField.text = "12345"
        phoneTextField.text = "787-123-4567"
        birthdayTextField.text = "1997-02-24"
        
        profilePicture.layer.cornerRadius = 6
        profilePicture.clipsToBounds = true
        
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelRegistration(_ sender: Any) {
        dismiss(animated:  true, completion: nil)
    }
    
    @IBAction func selectProfilePicture(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary

        present(imagePickerController, animated: true, completion: nil)
    }

    // MARK: ImagePicker Delegate Methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicture.contentMode = .scaleAspectFill
            profilePicture.image = pickedImage
        }

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://localhost/dcomida/api/register_user.php")! as URL)
        request.httpMethod = "POST"
        let postString = "email=\(emailTextField.text!)&username=\(usernameTextField.text!)&password=\(passwordTextField.text!)&name=\(nameTextField.text!)&initial=E&lastname=Colon&birthday=\(birthdayTextField.text!)&phoneNumber=\(phoneTextField.text!)&photo=\(profilePicture.image!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("error: \(String(describing: error))")
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response: \(String(describing: responseString))")

            }.resume()
        
    }
}
