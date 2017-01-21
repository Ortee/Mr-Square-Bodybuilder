//
//  GameController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 11.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import UIKit
import AVFoundation

class GameController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()

    func updateBalance() {
        cashLabel.text = "\(String(format: "%.2f", bodybuilder.getCash())) $"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateBalance()
    }
    @IBOutlet weak var cashLabel: UILabel!

    @IBAction func clickAction(_ sender: Any) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "coin", ofType: "wav")!))
        }
        catch{
            print(error)
        }
        audioPlayer.play()
        bodybuilder.increaseCash()
        updateBalance()
    }
}
