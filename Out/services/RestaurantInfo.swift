//
//  RestaurantInfo.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 5/3/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import Foundation
import UIKit

struct CategoryRestaurantInfo {
    var restaurantImage: UIImage
    var restaurantName: String
    var restaurantDescription: String
}

struct RestaurantInfo: Decodable {
    let resId: String
    let name: String
    let description: String
    let address: String
    let latitude: String
    let longitude: String
    let phoneNumber: String
    let mainPhoto: String
    let secondPhoto: String
    let thirdPhoto: String
    let characteristics: String
    let category: String
    let affordability: String
    
//    init(json: [String: Any]) {
//        resId = json["resId"] as? String ?? ""
//        name = json["name"] as? String ?? ""
//        description = json["description"] as? String ?? ""
//        address = json["address"] as? String ?? ""
//        latitude = json["latitude"] as? String ?? ""
//        longitude = json["longitude"] as? String ?? ""
//        phoneNumber = json["phoneNumber"] as? String ?? ""
//        mainPhoto = json["mainPhoto"] as? String ?? ""
//        secondPhoto = json["secondPhoto"] as? String ?? ""
//        thirdPhoto = json["thirdPhoto"] as? String ?? ""
//        characteristics = json["characteristics"] as? String ?? ""
//        category = json["category"] as? String ?? ""
//        affordability = json["affordability"] as? String ?? ""
//    }
}

class Restaurant {
    
    var res = [RestaurantInfo]()
    
    func getResInfo(completion: @escaping ([RestaurantInfo]) -> ()) {
        
        //url to get the data that is in the database
        let jsonUrlString = "http://localhost/dcomida/api/restaurant.php"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
                do {
                   let restaurants = try JSONDecoder().decode([RestaurantInfo].self, from: data)

                    for restaurant in restaurants {
                        self.res.append(RestaurantInfo(resId: restaurant.name, name: restaurant.name, description: restaurant.description, address: restaurant.address, latitude: restaurant.latitude, longitude: restaurant.longitude, phoneNumber: restaurant.phoneNumber, mainPhoto: restaurant.mainPhoto, secondPhoto: restaurant.secondPhoto, thirdPhoto: restaurant.thirdPhoto, characteristics: restaurant.characteristics, category: restaurant.category, affordability: restaurant.affordability))
                    }
                    completion(self.res)
                } catch let jsonError {
                    print("Error serializing json: \(jsonError)")
                }
            }.resume()
    }
}
