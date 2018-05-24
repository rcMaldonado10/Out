//
//  RestaurantTableViewController.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 5/14/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    

    @IBOutlet weak var mainPhoto: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var openStatus: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    @IBOutlet weak var resPhone: UIButton!
    let resInfo = Restaurant()
    
    var indexSelected = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        resInfo.getResInfo { res in
            for (index, myRes) in res.enumerated() {
                if (String(index) == self.indexSelected) {
                    DispatchQueue.main.async(execute: {
                        self.restaurantName.text = myRes.name
                        self.getImage(url: myRes.mainPhoto, imageView: self.mainPhoto)
                        self.resPhone.setTitle(myRes.phoneNumber, for: .normal)
                    })
                }
            }
        }
    }
    
    func getImage(url: String, imageView: UIImageView) {
        let url:URL = URL(string: url)!
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
            
            if data != nil {
                let image = UIImage(data: data!)
                if image != nil {
                    DispatchQueue.main.async(execute: {
                        imageView.image = image
                    })
                }
            }
        }.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeCall(_ sender: Any) {
    }
    
    @IBAction func showAddress(_ sender: Any) {
    }
    
    @IBAction func sendEmail(_ sender: Any) {
    }
    
    @IBAction func goToWebsite(_ sender: Any) {
    }
    
    @IBAction func goMenu(_ sender: Any) {
        
        
    }
    
}
