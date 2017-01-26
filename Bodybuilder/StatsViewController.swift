//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var bodybuilderImage: UIImageView!
    @IBOutlet weak var ExperiencePercentLabel: UILabel!
    @IBOutlet weak var EnergyLabel: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var experienceBar: UIProgressView!
    @IBOutlet weak var energyPercentLabel: UILabel!
    @IBOutlet weak var EnergyBar: UIProgressView!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var strengthGrowthLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var trainingTimeLeft: UILabel!
    var statsTimer = Timer()
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        let hours = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = (seconds % 3600) % 60
        
        return String(format:"%02i:%02i:%02i", hours, mins, secs)
    }
    
    func updateUserData() {
        strengthLabel.text = String(bodybuilder.getStrength())
        cashLabel.text = "\(String(format: "%.2f", bodybuilder.getCash()))$"
        strengthGrowthLabel.text = String(bodybuilder.getStrengthGrowth())
        EnergyLabel.text = "\(String(bodybuilder.getEnergy()))%"
        LevelLabel.text = String(bodybuilder.getLeveL())
        experienceBar.progress = bodybuilder.getPercentStrength()
        ExperiencePercentLabel.text = "\(Int(bodybuilder.getPercentStrength()*100))%"
        energyPercentLabel.text = "\(Int(bodybuilder.getEnergyPercent()))%"
        EnergyBar.progress = bodybuilder.getEnergyPercent()/100
        trainingTimeLeft.text = secondsToHoursMinutesSeconds(seconds: bodybuilder.getEnergy())
        bodybuilderImage.image = UIImage(named: "\(String(bodybuilder.getImageLevel()))_\(bodybuilder.getImageMood()).png")
    }
    
    func saveDataTimerSchedule() {
        httpRequest.updatePlayer(uuid: UIDevice.current.identifierForVendor!.uuidString)
        bodybuilder.saveData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodybuilder.loadData()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(saveDataTimerSchedule), userInfo: nil, repeats: true)
        statsTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUserData), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
