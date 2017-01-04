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
    var hunger: Int = 0;
    var cash: Int = 0;
    
    // incrase step
    var strengthIncreaseValue = 1;
    var cashIncreaseValue = 1;
    var hungerIncreaseValue = 1;

    
    init() {
        print("BODYBUILDER INIT")
    }
    
    func boostStrength(step: Int) {
        print("BOOST STRENGTH STEP: ", step)
        strength += step
    }
    
    func boostHunger(step: Int) {
        print("HUNGER STRENGTH STEP: ", step)
        hunger += step
    }
    
    func boostCash(step: Int) {
        print("CASH STRENGTH STEP: ", step)
        cash += step
    }
    
    func increaseStrength() {
        print("INCREASE STRENGTH")
        strength += strengthIncreaseValue
    }
    
    func increaseHunger() {
        print("INCREASE HUNGER")
        hunger += hungerIncreaseValue
    }
    
    func increaseCash() {
        print("INCREASE CASH")
        cash += cashIncreaseValue
    }
    
    
    func getStrength() -> Int{
        print("RETURN STRENGTH")
        return strength
    }
    
    func getHunger() -> Int {
        print("RETURN HUNGER")
        return hunger
    }
    
    func getCash() -> Int {
        print("RETURN CASH")
        return cash
    }
    
    func getStrengthIncreaseValue() -> Int {
        print("RETURN Strength Increase Value")
        return strengthIncreaseValue;
    }
    
    func getHungerIncreaseValue() -> Int {
        print("RETURN Hunger Increase Value")
        return hungerIncreaseValue;
    }
    
    func getCashIncreaseValue() -> Int {
        print("RETURN Cash Increase Value")
        return cashIncreaseValue;
    }
    
    func boostStrengthIncreaseValue(step: Int) {
        print("BOOST Strength Increase Value: ", step )
        strengthIncreaseValue += step
    }
    
    func boostHungerIncreaseValue(step: Int) {
        print("BOOST Hunger Increase Value: ", step )
        hungerIncreaseValue += step;
    }
    
    func boostCashIncreaseValue(step: Int) {
        print("BOOST Cash Increase Value: ", step )
        cashIncreaseValue += step;
    }
}
