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
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameFiled.text = bodybuilder.getNickname()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNickname(_ sender: Any) {
        bodybuilder.setNickname(_nickname: nicknameFiled.text!)
        let nicknameAlert = UIAlertController(title: "SUCCESS", message: "Nickname has been changed to \(nicknameFiled.text!).", preferredStyle: UIAlertControllerStyle.alert)
        nicknameAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(nicknameAlert, animated: true, completion: nil)
    }

    @IBAction func restartButton(_ sender: Any) {
        let restartAlert = UIAlertController(title: "Restart", message: "Are you sure? All data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        restartAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            bodybuilder.restartData()
        }))
        
        restartAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(restartAlert, animated: true, completion: nil)
        
        
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
