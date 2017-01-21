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
    @IBOutlet weak var coinRate: UILabel!
    var gameTimer = Timer()
    
    func updateInfo() {
        cashLabel.text = "\(String(format: "%.2f", bodybuilder.getCash())) $"
        coinRate.text = "\(bodybuilder.getCashRate()) / tap"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfo()
        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateInfo), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        updateInfo()
        bodybuilder.increaseExperiencePerSecond()
    }
}
