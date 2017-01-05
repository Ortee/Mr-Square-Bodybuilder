//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class ShopeViewController: UIViewController {
    
    var bodybuilder = (UIApplication.shared.delegate as! AppDelegate).bodybuilder
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func steak(_ sender: AnyObject) {
        bodybuilder.boostHunger(step: 2)
    }
    
    @IBAction func macbook(_ sender: AnyObject) {
        bodybuilder.boostCash(step: 2)
    }
    
    @IBAction func creatine(_ sender: AnyObject) {
        bodybuilder.boostStrength(step: 2)
    }
    
    
}
