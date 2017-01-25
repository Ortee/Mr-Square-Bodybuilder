//
//  RankingViewController.swift
//  Bodybuilder
//
//  Created by Denis Olek on 25.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import Alamofire
import SwiftyJSON

import UIKit

struct User {
    var id: String
    var device_uuid: String
    var nickname: String
    var strength: String
    var level: String
    var place: Int
}


class RankingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var rankingTableView: UITableView!

    var playersArray = [User]()
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.backgroundColor = UIColor(red: 51/255, green: 62/255, blue: 79/255, alpha: 1.0)
        cell.contentView.backgroundColor = UIColor(red: 51/255, green: 62/255, blue: 79/255, alpha: 1.0)
        cell.layer.borderColor = UIColor(red:0.58, green:0.53, blue:0.90, alpha:1.0).cgColor
        let colorView = UIView()
        colorView.backgroundColor = UIColor(red:0.58, green:0.53, blue:0.90, alpha:1.0)
        cell.selectedBackgroundView = colorView
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (playersArray.count)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RankingTableViewCell

        cell.place.text = "\(playersArray[indexPath.row].place)."
        cell.strength.text = "\(playersArray[indexPath.row].strength) strength"
        cell.name.text = playersArray[indexPath.row].nickname
        cell.level.text = "Level \(playersArray[indexPath.row].level)"
        return (cell)
    }

    override func viewWillAppear(_ animated: Bool) {
        let myGroup = DispatchGroup()
        myGroup.enter()
        httpRequest.getPlayers(players: playersArray, tableView: rankingTableView, myGroup: myGroup)
        myGroup.notify(queue: DispatchQueue.main, execute: {
            self.playersArray = httpRequest.players
            DispatchQueue.main.async{
                self.playersArray = httpRequest.players
                self.rankingTableView.reloadData()
            }
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
