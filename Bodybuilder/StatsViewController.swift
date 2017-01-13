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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        ExpLabel.text = String(bodybuilder.getExperience())
//        CashLabel.text = "\(String(format: "%.2f", bodybuilder.getCash()))$"
//        ExpPerMinute.text = String(bodybuilder.getExperienceIncreaseValue())
        EnergyLabel.text = "\(String(bodybuilder.getEnergy()))%"
        LevelLabel.text = String(bodybuilder.getLeveL())
        experienceBar.progress = bodybuilder.getPercentExperienceToBar()
        ExperiencePercentLabel.text = "\(Int(bodybuilder.getPercentExperienceToBar()*100))%"
        energyPercentLabel.text = "\(String(bodybuilder.getEnergy()))%"
        EnergyBar.progress = Float(bodybuilder.getEnergy())/100
        
        bodybuilderImage.image = UIImage(named: "\(String(bodybuilder.getImageLevel()))_\(bodybuilder.getImageMood()).png")
    }
    
}
