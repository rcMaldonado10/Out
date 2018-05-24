//
//  FeedViewController.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 5/6/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var newRestaurants: [CategoryRestaurantInfo] = []
    var eventRestaurants: [CategoryRestaurantInfo] = []
    
    let restaurantEvents = FeedService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRestaurants.append(CategoryRestaurantInfo(restaurantImage: #imageLiteral(resourceName: "restaurant1"), restaurantName: "D' Aqui", restaurantDescription:"El mejor pollo de Puerto Rico lo tenemos"))
        newRestaurants.append(CategoryRestaurantInfo(restaurantImage: #imageLiteral(resourceName: "restaurant2"), restaurantName: "El Sazón Caliente", restaurantDescription:"Mofongo con camarones, igual que el de Abuela"))
        newRestaurants.append(CategoryRestaurantInfo(restaurantImage: #imageLiteral(resourceName: "LoginBG"), restaurantName: "La Propina", restaurantDescription:"Comida Criolla como la tu casa"))
        
        eventRestaurants.append(CategoryRestaurantInfo(restaurantImage: #imageLiteral(resourceName: "apple"), restaurantName: "Festival de la manzana", restaurantDescription:"Ven y disfruta de todas las cosas maravillosas de la manzana"))
        eventRestaurants.append(CategoryRestaurantInfo(restaurantImage: #imageLiteral(resourceName: "LoginBG"), restaurantName: "Italy's Best", restaurantDescription:"La mejor comida Italiana, te sentiras en Roma"))
        eventRestaurants.append(CategoryRestaurantInfo(restaurantImage: #imageLiteral(resourceName: "restaurant2"), restaurantName: "Bate Q' Bate", restaurantDescription:"Prepara la mejor batida para el jurado"))
        
        restaurantEvents.getEvents { events
            for (index, events) in events.enumerated() {
                
            }
        }
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: CollectionView Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnValue = 0
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            returnValue = newRestaurants.count
            break
        case 1:
            returnValue = eventRestaurants.count
            break
        default:
            break
        }
        
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath)
        
        let cellImage = cell.viewWithTag(5) as! UIImageView
        let cellName = cell.viewWithTag(10) as! UILabel
        let cellDescription = cell.viewWithTag(15) as! UILabel
        
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
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cellName.text = newRestaurants[indexPath.row].restaurantName
            cellDescription.text = newRestaurants[indexPath.row].restaurantDescription
            cellImage.image = newRestaurants[indexPath.row].restaurantImage
            break
        case 1:
            cellName.text = eventRestaurants[indexPath.row].restaurantName
            cellDescription.text = eventRestaurants[indexPath.row].restaurantDescription
            cellImage.image = eventRestaurants[indexPath.row].restaurantImage
            break
        default:
            break
        }
        
        cellImage.roundCorners([.topLeft, .topRight], radius: 6)

        cell.contentView.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Cuadra el ancho para que sea el 90% del dispositivo. Esto es mas bien para el iPhone
        var cellSize = CGSize(width: UIScreen.main.bounds.width * 0.90, height: 300)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
        // It's an iPhone
        cellSize = CGSize(width: UIScreen.main.bounds.width * 0.90, height: 300)
            break
        case .pad:
        // It's an iPad
            
            //Aqui se juega con el UI para que haya mas celdas en la pantalla para sacar el maximo del espacio en pantalla
            switch UIDevice.current.orientation{
            case .portrait:
                
                let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
                layout.minimumInteritemSpacing = 4
                cellSize = CGSize(width:349,height: 300)
                break
                
            case .portraitUpsideDown:
                
                let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
                layout.minimumInteritemSpacing = 4
                cellSize = CGSize(width:349,height: 300)
                break
                
            case .landscapeLeft:
                
                let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                layout.sectionInset = UIEdgeInsetsMake(0, 90, 0, 90)
                layout.minimumInteritemSpacing = 4
                cellSize = CGSize(width:349,height: 300)
                break
                
            case .landscapeRight:
                let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                layout.sectionInset = UIEdgeInsetsMake(0, 90, 0, 90)
                layout.minimumInteritemSpacing = 4
                cellSize = CGSize(width:349,height: 300)
                break
                
            default:
                print("Hola")
                break
            }
        break
        case .unspecified:
            cellSize = CGSize(width: UIScreen.main.bounds.width * 0.90, height: 300);
        case .tv:
            break
        case .carPlay:
            break
        }
        
        return cellSize
    }
    
    //MARK: SegmentedBar Action
    @IBAction func updateCellContent(_ sender: Any) {
        collectionView.reloadData()
    }
    
}

// MARK: Extension to make the top corners if UIImageView rounded
extension UIImageView {
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        let rect = self.layer.bounds
        shape.path = maskPath.cgPath
        shape.frame = rect
        self.layer.mask = shape
    }
}
