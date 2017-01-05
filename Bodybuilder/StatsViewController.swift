//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var bodybuilder = (UIApplication.shared.delegate as! AppDelegate).bodybuilder

    @IBOutlet weak var trainingValue: UILabel!
    @IBOutlet weak var hungerValue: UILabel!
    @IBOutlet weak var cashValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func refresh(_ sender: AnyObject) {
        trainingValue.text = String(bodybuilder.getStrength())
        hungerValue.text = String(bodybuilder.getHunger())
        cashValue.text = String(bodybuilder.getCash())
    }
    
}
