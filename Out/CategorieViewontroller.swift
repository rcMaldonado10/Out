//
//  CategorieViewController.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 4/15/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import UIKit

class CategorieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var restaurants: [CategoryRestaurantInfo] = []
    
    var categorieTitle: String? = nil
    
    let resInfo = Restaurant()

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
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "ResTVC") as! RestaurantTableViewController
        desVC.indexSelected = "\(indexPath.row)"
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        let titleLabel = cell.viewWithTag(10) as! UILabel
        let subTitleLabel = cell.viewWithTag(15) as! UILabel
        let restaurantImage = cell.viewWithTag(20) as! UIImageView
        
        switch indexPath.row {
            default:
                resInfo.getResInfo { res in
                    for (index, myRes) in res.enumerated() {
                        if (index == indexPath.row) {
                            DispatchQueue.main.async(execute: {
                                if self.categorieTitle == myRes.category {
                                    titleLabel.text = myRes.name
                                    subTitleLabel.text = myRes.description
                                    self.getImage(url: myRes.mainPhoto, imageView: restaurantImage)
                                } else {
                                    titleLabel.text = "Lo sentimos"
                                    subTitleLabel.text = "No hay restaurantes en esta categoria"
                                }
                            })
                        }
                    }
                }
                
            cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
            cell.contentView.clipsToBounds = true
            cell.selectionStyle = .none
            break
        }
        return cell
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
}

