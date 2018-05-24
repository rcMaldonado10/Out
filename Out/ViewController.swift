//
//  ViewController.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 4/9/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Variable that references the UICollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    let number = 3
    
    let categorie = ["D' Restaurantes", "D' Picar", "D' Guauguita", "D' Antojos"]
    var valueToPass: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "LoginBG")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewControllerDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let label = cell.viewWithTag(5) as! UILabel
        let quantityLabel = cell.viewWithTag(10) as! UILabel
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.layer.cornerRadius = 6.0
        
        switch indexPath.row {
        default:
            label.text = categorie[indexPath.row];
            quantityLabel.text = String(number)
        }
        cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        cell.contentView.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: UIScreen.main.bounds.width * 0.90, height: 80);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        valueToPass = categorie[indexPath.row]
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryBoard.instantiateViewController(withIdentifier: "CategorieViewController") as! CategorieViewController
        desVC.categorieTitle = categorie[indexPath.row]
        desVC.navBar.title = categorie[indexPath.row]
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let categorieView = segue.destination as? CategorieViewController {
//            categorieView.categorieTitle = valueToPass
//            categorieView.navBar.title = valueToPass
//        }
//    }
}

