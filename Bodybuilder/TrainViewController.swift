//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class TrainViewController: UIViewController {
    
    var bodybuilder = (UIApplication.shared.delegate as! AppDelegate).bodybuilder
    
    @IBOutlet var strength: UILabel!
    @IBOutlet var hunger: UILabel!
    @IBOutlet var cash: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func training(_ sender: AnyObject) {
        bodybuilder.increaseStrength()
        strength.text = String(bodybuilder.getStrength())
    }
    @IBAction func eating(_ sender: AnyObject) {
        bodybuilder.increaseHunger()
        hunger.text = String(bodybuilder.getHunger())
    }
    
    @IBAction func working(_ sender: AnyObject) {
        bodybuilder.increaseCash()
        cash.text = String(bodybuilder.getCash())
    }
}
