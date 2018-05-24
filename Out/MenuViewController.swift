//
//  MenuViewController.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 5/15/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let menuImage = [UIImage(named:"burguer"), UIImage(named:"Pasta"), UIImage(named:"rice"), UIImage(named:"salmon")]
    let name = ["El Gran Burguer", "Le' Pasta", "Arroz Exotico", "Salmon Burritos"]
    let price = [7.99, 11.99, 9.90, 15.99]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        
        let foodImage = cell.viewWithTag(5) as! UIImageView
        let foodName = cell.viewWithTag(10) as! UILabel
        let foodPrice = cell.viewWithTag(15) as! UILabel
        
        switch indexPath.row {
        default:
            foodImage.image  = menuImage[indexPath.row]
            foodName.text = name[indexPath.row]
            foodPrice.text = "$ \(price[indexPath.row])"
        }
        
        return cell
    }
    

}
