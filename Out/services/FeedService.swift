//
//  FeedService.swift
//  Out
//
//  Created by Rafael Colon Maldonado on 5/23/18.
//  Copyright © 2018 Rafael Colon Maldonado. All rights reserved.
//

import Foundation

struct Events: Decodable {
    var eventId: String
    var resId: String
    var name: String
    var description: String
    var photo: String
    var date: String
    var price: String
    
    init(json: [String: Any]) {
        eventId = json["eventId"] as? String ?? ""
        resId = json["resId"] as? String ?? ""
        name = json["name"] as? String ?? ""
        description = json["description"] as? String ?? ""
        photo = json["photo"] as? String ?? ""
        date = json["date"] as? String ?? ""
        price = json["price"] as? String ?? ""
    }
}

class FeedService {
    
    func getEvents(completion: @escaping ([Events]) -> ()) {
        let jsonUrl = "http://localhost/dcomida/api/event.php"
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let events = try JSONDecoder().decode([Events].self, from: data)
                
                for event in events {
                    print(event)
                }
                
                completion(events)
            } catch let jsonError {
                print("Error serializing json: \(jsonError)")
            }
            }.resume()
        
    }
}
