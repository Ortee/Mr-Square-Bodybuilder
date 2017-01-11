//
//  GameController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 11.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var cashLabel: UILabel!

    @IBAction func clickAction(_ sender: Any) {
        bodybuilder.increaseCash()
        cashLabel.text = "\(String(format: "%.2f", bodybuilder.getCash()))$"
    }


}
