//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class ShopeViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func riceButton(_ sender: Any) {
        bodybuilder.buyItem(price: 1.00, strengthBoost: 10)
    }
    
    @IBAction func steroidsButton(_ sender: Any) {
        bodybuilder.buyItem(price: 2.00, strengthBoost: 50)
    }
}
