//
//  position.swift
//  Bodybuilder
//
//  Created by Denis Olek on 06.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import Foundation

class Position {
    var latitude: Double = 52.43742495
    var longitude: Double = 16.91821575
    
    func getLatitude() -> Double {
        return latitude
    }
    
    func getLongitude() -> Double {
        return longitude
    }
    
    func setLatitude(_latitude: Double) {
        latitude = _latitude
    }
    
    func setLongitude(_longitude: Double) {
        longitude = _longitude
    }
    
    func setPosition(_latitude: Double, _longitude: Double) {
        latitude = _latitude
        longitude = _longitude
    }
}

var position: Position = Position()
