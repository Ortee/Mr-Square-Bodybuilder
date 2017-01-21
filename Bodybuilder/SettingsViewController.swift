//
//  SettingsViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 21.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var nicknameFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameFiled.text = bodybuilder.getNickname()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNickname(_ sender: Any) {
        bodybuilder.setNickname(_nickname: nicknameFiled.text!)
    }

    @IBAction func restartButton(_ sender: Any) {
        bodybuilder.restartData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
