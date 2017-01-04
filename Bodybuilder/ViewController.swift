//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bodybuilder: Bodybuilder = Bodybuilder()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func training(_ sender: UIButton) {
        bodybuilder.increaseStrength()
    }
    
    @IBAction func eating(_ sender: UIButton) {
        bodybuilder.increaseHunger()
    }
    
    
    @IBAction func working(_ sender: UIButton) {
        bodybuilder.increaseCash()
    }
    
}
