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
    var strength: Int = 0
    var strengthGrowth = 1
    let CIRCLE_MAX_RADIUS: Double = 0.0004
    let maxEnergy = 10800
    var energy: Int = 10800
    var cash: Float = 0.00
    var level: Int = 1
    var isSad: Bool = false;
    var nickname: String = "Player"
    
    init() {
        let myGroup = DispatchGroup()
        myGroup.enter()
        httpRequest.getPlayer(uuid: UIDevice.current.identifierForVendor!.uuidString, myGroup: myGroup)
        myGroup.notify(queue: DispatchQueue.main, execute: {
            var player = httpRequest.player
            DispatchQueue.main.async{
                player = httpRequest.player
                if player == nil {
                    httpRequest.addPlayer()
                }
            }
        })
    }
    
    func setNickname(_nickname: String) {
        nickname = _nickname
    }
    
    func getNickname() -> String {
        return nickname
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
    
    func getPercentStrength() -> Float {
        if(level>1){
            return ( Float(strength - getExperienceForLevel(_level: level)) / Float(getExperienceForLevel(_level: level + 1) - getExperienceForLevel(_level: level)))
        }
        return ( Float(strength) / Float(getExperienceForLevel(_level: level + 1)) )
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

    
    //STRENGTH
    
    func boostStrengthGrow(step: Int) {
        strength += step
    }
    
    func increaseStrengthGrow() {
        let nextLevelExp = getExperienceForLevel(_level: level + 1)
        if (strength >= nextLevelExp){
            level += 1
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "level_up", ofType: "wav")!))
            }
            catch{
                print(error)
            }
            audioPlayer.play()
        }
        strength += strengthGrowth
    }
    
    func getStrength() -> Int{
        return strength
    }
    
    
    func getStrengthGrowth() -> Int {
        return strengthGrowth;
    }
    
    func booststrengthGrowth(step: Int) {
        strengthGrowth += step
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
        cash += (0.05 * Float(level) * 0.55)
    }
    
    func buyItem(price: Float, strengthBoost: Int) -> Bool{
        if(cash >= price) {
            cash -= price
            strengthGrowth += strengthBoost
            return true
        }
        
        return false
    }
    
    func saveData() {
        updateSingleIntegerRecord(value: level, recordName: "level")
        updateSingleIntegerRecord(value: strength, recordName: "strength")
        updateSingleIntegerRecord(value: strengthGrowth, recordName: "strength_growth")
        updateSingleFloatRecord(value: cash, recordName: "cash")
        updateSingleStringRecord(value: nickname, recordName: "nickname")
    }
    
    func loadData() {
        level = getIntRecord(recordName: "level")
        cash = getFloatRecord(recordName: "cash")
        strength = getIntRecord(recordName: "strength")
        strengthGrowth = getIntRecord(recordName: "strength_growth")
        nickname = getStringRecord(recordName: "nickname")
    }
    
    func restartData() {
        updateSingleIntegerRecord(value: 0, recordName: "strength")
        updateSingleIntegerRecord(value: 1, recordName: "strength_growth")
        updateSingleFloatRecord(value: 0.00, recordName: "cash")
        updateSingleIntegerRecord(value: 1, recordName: "level")
        strength = 0
        cash = 0.00
        level = 1
        strengthGrowth = 1
    }
    
}

var bodybuilder: Bodybuilder = Bodybuilder()

