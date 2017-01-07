//
//  bodybuilder.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 04.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import Foundation

class Bodybuilder {
    var strength: Int = 0
    var strengthIncreaseValue = 1
    let CIRCLE_MAX_RADIUS: Double = 0.002
    
    init() {
        print("BODYBUILDER INIT")
    }
    
    func checkBodybuilderIsOnGym(_gymlist: [Gym], _latitude: Double, _longitude: Double) -> Bool {
        for gym in _gymlist {
            if((Swift.abs(gym.getLatitude() - _latitude) < CIRCLE_MAX_RADIUS ) && ( Swift.abs(gym.getLongitude() - _longitude) < CIRCLE_MAX_RADIUS)) {
                return true
            }
        }
        return false
    }
    
    
    func boostStrength(step: Int) {
        print("BOOST STRENGTH STEP: ", step)
        strength += step
    }
    
    func increaseStrength() {
        print("INCREASE STRENGTH")
        strength += strengthIncreaseValue
    }
    
    func getStrength() -> Int{
        print("RETURN STRENGTH")
        return strength
    }
    
    func getStrengthIncreaseValue() -> Int {
        print("RETURN Strength Increase Value")
        return strengthIncreaseValue;
    }
    
    func boostStrengthIncreaseValue(step: Int) {
        print("BOOST Strength Increase Value: ", step )
        strengthIncreaseValue += step
    }
}

var bodybuilder: Bodybuilder = Bodybuilder()

