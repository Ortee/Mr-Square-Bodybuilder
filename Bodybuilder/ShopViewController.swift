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
        Item(image: "02_coffee", name: "Coffee", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "03_banana", name: "Banana", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "04_oats", name: "Oats", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "05_bacon", name: "Bacon", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "06_salad", name: "Salad", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "07_egg", name: "Egg", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "08_fries", name: "Fries", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "09_pasta", name: "Pasta", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "10_rice", name: "Rice", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "11_salami", name: "Salami", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "12_chicken", name: "Chicken", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "13_steak", name: "Steak", description: "+1 str/s", price: 1, strengthBoost: 1)
    ]
    
    let suplements = [
        Item(image: "14_energy-drink", name: "Energy Drink", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "15_vitamins", name: "Vitamins", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "16_bcaa", name: "Bcaa", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "17_creatine", name: "Creatine", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "18_protein-powder", name: "Protein Powder", description: "+1 str/s", price: 1, strengthBoost: 1),
    ]
    
    let steroids = [
        Item(image: "19_testosterone", name: "Testosterone", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "20_trenbolone", name: "Trenbolone", description: "+1 str/s", price: 1, strengthBoost: 1),
        Item(image: "21_synthol", name: "Synthol", description: "+1 str/s", price: 1, strengthBoost: 1),
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
        print("INDEX: \(segmentedIndexCount)")
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
