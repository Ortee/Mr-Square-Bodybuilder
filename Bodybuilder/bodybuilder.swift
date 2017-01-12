//
//  bodybuilder.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 04.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import Foundation

class Bodybuilder {
    var experience: Int = 0
    var experienceIncreaseValue = 1
    var cashIncreaseValue: Float = 0.01
    let CIRCLE_MAX_RADIUS: Double = 0.002
    var cash: Float = 0.00
    var energy: Int = 100
    var level: Int = 1
    
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

    //LEVEL
    
    func getLeveL() -> Int {
        return level
    }
    
    
    func getExperienceForLevel(_level: Int) -> Int {
        return ((50 * _level * _level * _level) - (150 * _level * _level) + (400 * _level)) / 3
    }
    
    func getPercentExperienceToBar() -> Float {
        if(level>1){
            return ( Float(experience - getExperienceForLevel(_level: level)) / Float(getExperienceForLevel(_level: level + 1) - getExperienceForLevel(_level: level)))
        }
        return ( Float(experience) / Float(getExperienceForLevel(_level: level + 1)) )
    }

    
    //EXPERIENCE
    
    func boostExperienceStep(step: Int) {
        experience += step
    }
    
    func increaseExperiencePerSecond() {
        let nextLevelExp = getExperienceForLevel(_level: level + 1)
        print("NEXT LEVEL:", nextLevelExp)
        print("EXPL:", experience)
        if (experience >= nextLevelExp){
            level += 1
        }
        experience += experienceIncreaseValue
    }
    
    func getExperience() -> Int{
        return experience
    }
    
    
    func getExperienceIncreaseValue() -> Int {
        return experienceIncreaseValue;
    }
    
    func boostExperienceIncreaseValue(step: Int) {
        experienceIncreaseValue += step
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
            experienceIncreaseValue += strengthBoost
        }
    }
    
    //ENERGY
    
    func getEnergy() -> Int {
        return energy
    }
    
    func consumptionEnergy() {
        energy -= 1
    }
    
    func reconditioningEnergy() {
        energy += 1
    }
    
}

var bodybuilder: Bodybuilder = Bodybuilder()

