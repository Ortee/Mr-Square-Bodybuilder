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
    var cashIncreaseValue: Float = 0.01
    let CIRCLE_MAX_RADIUS: Double = 0.002
    var cash: Float = 0.00
    var energy: Int = 100
    
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
    
    //STRENGTH
    
    func boostStrength(step: Int) {
        strength += step
    }
    
    func increaseStrength() {
        strength += strengthIncreaseValue
    }
    
    func getStrength() -> Int{
        return strength
    }
    
    
    func getStrengthIncreaseValue() -> Int {
        return strengthIncreaseValue;
    }
    
    func boostStrengthIncreaseValue(step: Int) {
        strengthIncreaseValue += step
    }
    
    //CASH
    
    func getCash()-> Float {
        return cash
    }
    
    func increaseCash(){
        cash += cashIncreaseValue
    }
    
    func buyItem(price: Float, strengthBoost: Int) {
        if(cash >= price) {
            cash -= price
            strengthIncreaseValue += strengthBoost
        }
    }
    
    //ENERGY
    
    func getEnergy() -> Int {
        return energy
    }
    
    func decreaseEnergy() {
        energy -= 1
    }
    
}

var bodybuilder: Bodybuilder = Bodybuilder()

