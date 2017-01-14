//
//  gym.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 05.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import Foundation

class Gym {
    var latitude: Double
    var longitude: Double
    var name: String
    var address: String
    
    init(nam: String, add: String, lat: Double, long: Double) {
        name = nam
        address = add
        latitude = lat
        longitude = long
    }
    
    func getName() -> String {
        return name
    }
    
    func getAddress() -> String {
        return address
    }
    
    func getLatitude() -> Double {
        return latitude
    }
    
    func getLongitude() -> Double {
        return longitude
    }
    
}

class Gyms {
    var list:[Gym] = []
    
    func setGyms(lGym: [Gym]) {
        list = lGym
    }
    
    func getGyms() -> [Gym] {
        return list
    }
    
    func getNerbyGyms(latitude: Double, longitude: Double) {
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=3000&type=gym&keyword=silownia&key=AIzaSyDJo8nIHl3JbPGLmpyZbMA7PkQMZj_AeUw")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let posts = json["results"] as? [[String: Any]] ?? []
                var gymsArray: [Gym] = []
                for gym in posts {
                    gymsArray.append(
                        Gym(
                            nam: gym["name"] as! String,
                            add: gym["vicinity"] as! String,
                            lat: ((gym["geometry"] as! Dictionary<String, Any>)["location"] as! Dictionary<String, Double>)["lat"] as! Double!,
                            long: ((gym["geometry"] as! Dictionary<String, Any>)["location"] as! Dictionary<String, Double>)["lng"] as! Double!
                        )
                    )
                    
                }
                self.list = gymsArray
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }


}

var gymList: Gyms = Gyms();
