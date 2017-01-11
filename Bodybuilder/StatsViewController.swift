//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var StrengthLabel: UILabel!
    @IBOutlet weak var CashLabel: UILabel!
    @IBOutlet weak var EnergyLabel: UILabel!
    @IBOutlet weak var StrengthPerMinute: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        StrengthLabel.text = String(bodybuilder.getStrength())
        CashLabel.text = "\(String(format: "%.2f", bodybuilder.getCash()))$"
        StrengthPerMinute.text = String(bodybuilder.getStrengthIncreaseValue())
        EnergyLabel.text = "\(String(bodybuilder.getEnergy()))%"
    }
    
}
