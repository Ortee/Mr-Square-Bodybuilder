//
//  bodybuilder.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 04.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class Bodybuilder {
    var audioPlayer = AVAudioPlayer()
    var experience: Int = 0
    var experienceIncreaseValue = 1
    var cashIncreaseValue: Float = 0.05
    let CIRCLE_MAX_RADIUS: Double = 0.0004
    let maxEnergy = 10800
    var energy: Int = 10800
    var cash: Float = 0.00
    var level: Int = 1
    var isSad: Bool = false;
    var click_count: Int = 0
    var time_on_gym: Int = 0
    var money_spent: Int = 0
    
    init() {
        print("BODYBUILDER INIT")
        print("DEVICE UUID: \(UIDevice.current.identifierForVendor!.uuidString)")
    }
    
    func checkBodybuilderIsOnGym(_gymlist: [Gym], _latitude: Double, _longitude: Double) -> Bool {
        for gym in _gymlist {
            if((Swift.abs(gym.getLatitude() - _latitude) < CIRCLE_MAX_RADIUS ) && ( Swift.abs(gym.getLongitude() - _longitude) < CIRCLE_MAX_RADIUS)) {
                return true
            }
        }
        return false
    }
    
    func checkGymName(_gymlist: [Gym], _latitude: Double, _longitude: Double) -> Gym {
        var Gym:Gym!
        for gym in _gymlist {
            if((Swift.abs(gym.getLatitude() - _latitude) < CIRCLE_MAX_RADIUS ) && ( Swift.abs(gym.getLongitude() - _longitude) < CIRCLE_MAX_RADIUS)) {
                Gym = gym
            }
        }
        return Gym
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
    
    func getImageLevel() -> Int {
        if(level/5<1){
            return 1
        }
        return (level/5)+1
    }
    
    func getImageMood() -> String {
        if(isSad) {
            return "sad"
        }
        return "happy"
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
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "level_up", ofType: "wav")!))
            }
            catch{
                print(error)
            }
            audioPlayer.play()
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
    
    //ENERGY
    
    func getEnergy() -> Int {
        return energy
    }
    
    func getEnergyPercent() -> Float {
        return ( Float(energy) / Float(maxEnergy) * 100)
    }
    
    func consumptionEnergy() {
        energy -= 1
        if energy < 0 {
            energy = 0
        }
    }
    
    func reconditioningEnergy() {
        energy += 1
    }
    
    func addEnergy(_energy: Int) {
        energy += energy
    }
    
    //CASH
    
    func addCash(count: Float) {
        cash += count
    }
    
    func getCash()-> Float {
        return cash
    }
    
    func getCashRate() -> String {
        return String(0.05 * Float(level) * 0.55)
    }
    func increaseCash(){
        cash += (cashIncreaseValue * Float(level) * 0.55)
    }
    
    func buyItem(price: Float, strengthBoost: Int) -> Bool{
        if(cash >= price) {
            cash -= price
            experienceIncreaseValue += strengthBoost
            return true
        }
        
        return false
    }
    
    func saveData() {
        updateSingleIntegerRecord(value: click_count, recordName: "click_count")
        updateSingleIntegerRecord(value: experience, recordName: "strength")
        updateSingleIntegerRecord(value: experienceIncreaseValue, recordName: "strength_growth")
        updateSingleIntegerRecord(value: time_on_gym, recordName: "time_on_gym")
        updateSingleIntegerRecord(value: money_spent, recordName: "money_spent")
        updateSingleFloatRecord(value: cash, recordName: "coins")
    }
    
    func loadData() {
        cash = getFloatRecord(recordName: "coins")
        experience = getIntRecord(recordName: "strength")
        experienceIncreaseValue = getIntRecord(recordName: "strength_growth")
        time_on_gym = getIntRecord(recordName: "time_on_gym")
        money_spent = getIntRecord(recordName: "money_spent")
        click_count = getIntRecord(recordName: "click_count")
    }
    
}

var bodybuilder: Bodybuilder = Bodybuilder()

