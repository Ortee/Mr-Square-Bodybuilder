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

}

var gymList: Gyms = Gyms();
