//
//  FoodDropViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 21.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import UIKit
import AVFoundation

class FoodDropViewController: UIViewController {
    
    var eatPlayer = AVAudioPlayer()
    var soundtrackPlayer = AVAudioPlayer()
    

    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var character: UIImageView!
    @IBOutlet weak var element1: UIImageView!
    @IBOutlet weak var element2: UIImageView!
    @IBOutlet weak var element3: UIImageView!
    @IBOutlet weak var element4: UIImageView!
    @IBOutlet weak var element5: UIImageView!
    @IBOutlet weak var element6: UIImageView!
    @IBOutlet weak var element7: UIImageView!
    @IBOutlet weak var element8: UIImageView!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    @IBOutlet weak var heart4: UIImageView!
    @IBOutlet weak var finishView: UIView!
    @IBOutlet weak var finishCashLabel: UILabel!
    
    @IBAction func playAgain(_ sender: Any) {
        resetHearts()
        gameTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(dropElements), userInfo: nil, repeats: true)
        points = 0
        finishView.isHidden = true
        pointsLabel.text = String(points)
        character.frame.origin.x = CGFloat(50)
        randomElement(element: element1)
        randomElement(element: element2)
        randomElement(element: element3)
        randomElement(element: element4)
        randomElement(element: element5)
        randomElement(element: element6)
        randomElement(element: element7)
        randomElement(element: element8)
        element1.frame.origin.y = 50
        element2.frame.origin.y = 30
        element3.frame.origin.y = -20
        element4.frame.origin.y = -70
        element5.frame.origin.y = -120
        element6.frame.origin.y = -170
        element7.frame.origin.y = -220
        element8.frame.origin.y = -270
    }
    
    var hearts: Int = 4
    var moveLeftTimer = Timer();
    var moveRightTimer = Timer();
    var points = 0;
    var gameTimer = Timer()
    
    var foodImages = ["01_water", "02_coffe", "03_banana", "04_oats", "05_bacon", "06_salad", "07_egg", "08_fries", "09_pasta", "10_rice", "11_salami", "12_chicken", "13_steak", "14_energy-drink", "15_vitamins", "16_bcaa", "17_creatine", "18_protein-powder", "19_testosterone", "20_trenbolone", "21_synythol"]

    func updateBalance() {
        cashLabel.text = "\(String(format: "%.2f", bodybuilder.getCash()))$"
    }
    
    func dropping(element: UIImageView) {
        if( element.frame.origin.y < 620) {
            element.frame.origin.y += 1
        } else {
            loseHeart()
            resetElement(element: element)
        }
    }
    
    func loseHeart() {
        hearts -= 1
        switch hearts {
        case 3:
            heart4.isHidden = true
        case 2:
            heart3.isHidden = true
        case 1:
            heart2.isHidden = true
        case 0:
            heart1.isHidden = true
            finishGame()
        default:
            break
        }
    }
    
    func resetHearts(){
        heart1.isHidden = false
        heart2.isHidden = false
        heart3.isHidden = false
        heart4.isHidden = false
        hearts = 4
    }
    
    func finishGame(){
        gameTimer.invalidate()
        finishView.isHidden = false
        finishCashLabel.text = "You earned \(Float(Float(points) * 0.1))$"
        bodybuilder.addCash(count: Float(Float(points) * 0.1))
        points = 0
        updateBalance()
    }
    
    func resetElement(element: UIImageView) {
        element.frame.origin.y = -100
        randomElement(element: element)
    }
    
    func randomElement(element: UIImageView) {
        let random: CGFloat = CGFloat(Int(Int(arc4random_uniform(280)) - 20));
        element.frame.origin.x = random
        element.image = UIImage(named: "\(foodImages[Int(arc4random_uniform(20))]).png")
    }
    
    func dropElements() {
        dropping(element: element1)
        dropping(element: element2)
        dropping(element: element3)
        dropping(element: element4)
        dropping(element: element5)
        dropping(element: element6)
        dropping(element: element7)
        dropping(element: element8)
        eating(food: element1)
        eating(food: element2)
        eating(food: element3)
        eating(food: element4)
        eating(food: element5)
        eating(food: element6)
        eating(food: element7)
        eating(food: element8)
    }
    
    func eating(food: UIImageView) {
        if(abs(character.frame.origin.x+70 - food.frame.origin.x) < 40) {
            if(character.frame.origin.y - food.frame.origin.y < 10){
                resetElement(element: food)
                points += 1
                pointsLabel.text = String(points)
                do {
                    eatPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "game-eat", ofType: "wav")!))
                }
                catch{
                    print(error)
                }
                eatPlayer.play()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hearts = 4
        randomElement(element: element1)
        randomElement(element: element2)
        randomElement(element: element3)
        randomElement(element: element4)
        randomElement(element: element5)
        randomElement(element: element6)
        randomElement(element: element7)
        randomElement(element: element8)
        element4.frame.origin.y = -70
        element5.frame.origin.y = -120
        element6.frame.origin.y = -170
        element7.frame.origin.y = -220
        element8.frame.origin.y = -270
        updateBalance()
        character.image = UIImage(named: "\(String(bodybuilder.getImageLevel()))_\(bodybuilder.getImageMood()).png")
        gameTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(dropElements), userInfo: nil, repeats: true)
        do {
            soundtrackPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "game-soundtrack", ofType: "wav")!))
        }
        catch{
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        soundtrackPlayer.numberOfLoops = -1
        soundtrackPlayer.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        finishGame()
        soundtrackPlayer.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func moveRight() {
        if(character.frame.origin.x < 250){
            character.frame.origin.x += 5
        }
    }
    
    func moveLeft() {
        if(character.frame.origin.x > -55){
            character.frame.origin.x -= 5
        }
    }
    
    @IBAction func moveRightTouchDown(_ sender: Any) {
        moveRightTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(moveRight), userInfo: nil, repeats: true)
    }
    
    @IBAction func moveRightTouchUp(_ sender: Any) {
        moveRightTimer.invalidate()
    }
    
    @IBAction func moveLeftTouchDown(_ sender: Any) {
        moveLeftTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(moveLeft), userInfo: nil, repeats: true)
    }
    @IBAction func moveLeftTouchUp(_ sender: Any) {
        moveLeftTimer.invalidate()
    }
    
}
