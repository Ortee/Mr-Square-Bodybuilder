//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var ExpLabel: UILabel!
    @IBOutlet weak var CashLabel: UILabel!
    @IBOutlet weak var EnergyLabel: UILabel!
    @IBOutlet weak var ExpPerMinute: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ExpLabel.text = String(bodybuilder.getExperience())
        CashLabel.text = "\(String(format: "%.2f", bodybuilder.getCash()))$"
        ExpPerMinute.text = String(bodybuilder.getExperienceIncreaseValue())
        EnergyLabel.text = "\(String(bodybuilder.getEnergy()))%"
        LevelLabel.text = String(bodybuilder.getLeveL())
    }
    
}
