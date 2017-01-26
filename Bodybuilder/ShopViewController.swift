//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit
import AVFoundation


class ShopeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var userBalance: UILabel!
    @IBOutlet weak var shopSegmentedControl: UISegmentedControl!
    @IBOutlet weak var shopTableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    
    func updateBalance() {
        userBalance.text = "\(String(format: "%.2f", bodybuilder.getCash()))$"
    }
    
    struct Item {
        var image: String
        var name: String
        var description: String
        var price: Float
        var strengthBoost: Int
    }
    
    let foods = [
        Item(image: "01_water", name: "Water", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "02_coffee", name: "Coffee", description: "+3 str/s", price: 2, strengthBoost: 3),
        Item(image: "03_banana", name: "Banana", description: "+5 str/s", price: 3, strengthBoost: 5),
        Item(image: "04_oats", name: "Oats", description: "+8 str/s", price: 6, strengthBoost: 8),
        Item(image: "05_bacon", name: "Bacon", description: "+11 str/s", price: 8, strengthBoost: 11),
        Item(image: "06_salad", name: "Salad", description: "+14 str/s", price: 10, strengthBoost: 14),
        Item(image: "07_egg", name: "Egg", description: "+18 str/s", price: 13, strengthBoost: 18),
        Item(image: "08_fries", name: "Fries", description: "+22 str/s", price: 16, strengthBoost: 22),
        Item(image: "09_pasta", name: "Pasta", description: "+26 str/s", price: 19, strengthBoost: 26),
        Item(image: "10_rice", name: "Rice", description: "+30 str/s", price: 22, strengthBoost: 30),
        Item(image: "11_salami", name: "Salami", description: "+35 str/s", price: 26, strengthBoost: 35),
        Item(image: "12_chicken", name: "Chicken", description: "+40 str/s", price: 30, strengthBoost: 40),
        Item(image: "13_steak", name: "Steak", description: "+50 str/s", price: 35, strengthBoost: 50)
    ]
    
    let suplements = [
        Item(image: "14_energy-drink", name: "Energy Drink", description: "+60 str/s", price: 40, strengthBoost: 60),
        Item(image: "15_vitamins", name: "Vitamins", description: "+70 str/s", price: 45, strengthBoost: 70),
        Item(image: "16_bcaa", name: "Bcaa", description: "+80 str/s", price: 50, strengthBoost: 80),
        Item(image: "17_creatine", name: "Creatine", description: "+90 str/s", price: 55, strengthBoost: 90),
        Item(image: "18_protein-powder", name: "Protein Powder", description: "+100 str/s", price: 60, strengthBoost: 100),
    ]
    
    let steroids = [
        Item(image: "19_testosterone", name: "Testosterone", description: "+120 str/s", price: 70, strengthBoost: 120),
        Item(image: "20_trenbolone", name: "Trenbolone", description: "+150 str/s", price: 80, strengthBoost: 150),
        Item(image: "21_synthol", name: "Synthol", description: "+200 str/s", price: 100, strengthBoost: 200),
    ]
    
    
    @IBAction func segmentedActionChanged(_ sender: Any) {
        shopTableView.reloadData()
    }
  

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var segmentedIndexCount = 0
        
        switch(shopSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            segmentedIndexCount = foods.count
            break
        case 1:
            segmentedIndexCount = suplements.count
            break
        case 2:
            segmentedIndexCount = steroids.count
            break
            
        default:
            break
            
        }
        return segmentedIndexCount
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.backgroundColor = UIColor(red: 51/255, green: 62/255, blue: 79/255, alpha: 1.0)
        cell.contentView.backgroundColor = UIColor(red: 51/255, green: 62/255, blue: 79/255, alpha: 1.0)
        cell.layer.borderColor = UIColor(red:0.58, green:0.53, blue:0.90, alpha:1.0).cgColor
        let colorView = UIView()
        colorView.backgroundColor = UIColor(red:0.58, green:0.53, blue:0.90, alpha:1.0)
        cell.selectedBackgroundView = colorView
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        switch(shopSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            cell.foodImage.image = UIImage(named: (foods[indexPath.row].image + ".png"))
            cell.foodName.text = foods[indexPath.row].name
            cell.foodDescription.text = foods[indexPath.row].description
            cell.foodPrice.text = "\(String(format: "%.2f", foods[indexPath.row].price))$"
            break
        case 1:
            cell.foodImage.image = UIImage(named: (suplements[indexPath.row].image + ".png"))
            cell.foodName.text = suplements[indexPath.row].name
            cell.foodDescription.text = suplements[indexPath.row].description
            cell.foodPrice.text = "\(String(format: "%.2f", suplements[indexPath.row].price))$"
            break
        case 2:
            cell.foodImage.image = UIImage(named: (steroids[indexPath.row].image + ".png"))
            cell.foodName.text = steroids[indexPath.row].name
            cell.foodDescription.text = steroids[indexPath.row].description
            cell.foodPrice.text = "\(String(format: "%.2f", steroids[indexPath.row].price))$"
            break
            
        default:
            break
            
        }
        

        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(shopSegmentedControl.selectedSegmentIndex)
        {
        case 0:
            if !bodybuilder.buyItem(price: foods[indexPath.row].price, strengthBoost: foods[indexPath.row].strengthBoost) {
                let alert = UIAlertController(title: "Not enought money", message: "You don't have enought money to buy this item. Play our minigames to earn some money.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "error", ofType: "wav")!))
                }
                catch{
                    print(error)
                }
                audioPlayer.play()
            } else {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "shop", ofType: "wav")!))
                }
                catch{
                    print(error)
                }
                audioPlayer.play()
            }
            tableView.deselectRow(at: indexPath, animated: false)
            updateBalance()
            break
        case 1:
            if !bodybuilder.buyItem(price: suplements[indexPath.row].price, strengthBoost: suplements[indexPath.row].strengthBoost) {
                let alert = UIAlertController(title: "Not enought money", message: "You don't have enought money to buy this item. Play our minigames to earn some money.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "error", ofType: "wav")!))
                }
                catch{
                    print(error)
                }
                audioPlayer.play()
            } else {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "shop", ofType: "wav")!))
                }
                catch{
                    print(error)
                }
                audioPlayer.play()
            }
            tableView.deselectRow(at: indexPath, animated: false)
            updateBalance()
            break
        case 2:
            if !bodybuilder.buyItem(price: steroids[indexPath.row].price, strengthBoost: steroids[indexPath.row].strengthBoost) {
                let alert = UIAlertController(title: "Not enought money", message: "You don't have enought money to buy this item. Play our minigames to earn some money.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "error", ofType: "wav")!))
                }
                catch{
                    print(error)
                }
                audioPlayer.play()
            } else {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "shop", ofType: "wav")!))
                }
                catch{
                    print(error)
                }
                audioPlayer.play()
            }
            tableView.deselectRow(at: indexPath, animated: false)
            updateBalance()
            break
            
        default:
            break
            
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        userBalance.text = "\(String(format: "%.2f", bodybuilder.getCash()))$"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
