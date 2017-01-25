//
//  http.swift
//  Bodybuilder
//
//  Created by Denis Olek on 25.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Http {
    public var players: [User] = [];
    
    func getPlayers(players: [User], tableView: UITableView, myGroup: DispatchGroup){
        
        var playersArray = players
        Alamofire.request("http://orteedev.pl:3000/api/users").responseJSON { response in
            debugPrint(response)
            
            let json = JSON(data: response.data!)
            playersArray.removeAll()
            var playerPlace = 0
            for (index,subJson):(String, JSON) in json {
                playerPlace += 1
                playersArray.append(User(id: index, device_uuid: String(describing: subJson["device_uuid"]), nickname: String(describing: subJson["nickname"]), strength: String(describing: subJson["strength"]), level: String(describing: subJson["level"]), place: playerPlace))
            }
            DispatchQueue.main.async{
                tableView.reloadData()
            }
            self.players = playersArray
            myGroup.leave()
        }
    }
}
var httpRequest: Http = Http()
