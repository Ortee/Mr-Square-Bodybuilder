//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit

class ShopeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var userBalance: UILabel!
    
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
  

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
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
        
        cell.foodImage.image = UIImage(named: (foods[indexPath.row].image + ".png"))
        cell.foodName.text = foods[indexPath.row].name
        cell.foodDescription.text = foods[indexPath.row].description
        cell.foodPrice.text = "\(String(format: "%.2f", foods[indexPath.row].price))$"
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !bodybuilder.buyItem(price: foods[indexPath.row].price, strengthBoost: foods[indexPath.row].strengthBoost) {
            let alert = UIAlertController(title: "Not enought money", message: "You don't have enought money to buy this item. Play our minigames to earn some money.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: false)
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
