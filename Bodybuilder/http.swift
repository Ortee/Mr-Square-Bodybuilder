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
    public var player: JSON = []
    
    func getPlayers(players: [User], tableView: UITableView, myGroup: DispatchGroup) {
        
        var playersArray = players
        Alamofire.request("http://orteedev.pl:3000/api/users").responseJSON { response in
            
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
    
    func getPlayer(uuid: String, myGroup: DispatchGroup) {
        Alamofire.request("http://orteedev.pl:3000/api/users/\(uuid)").responseJSON { response in
            let json = JSON(data: response.data!)
            self.player = json
            myGroup.leave()
        }
    }
    
    func addPlayer() {
        let random = Int(arc4random_uniform(9000))

        let params: Parameters = [
            "device_uuid": "\(UIDevice.current.identifierForVendor!.uuidString)",
            "level": bodybuilder.getLeveL(),
            "strength": bodybuilder.getStrength(),
            "nickname": "Player\(random)"
        ]

        Alamofire.request("http://orteedev.pl:3000/api/users", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            bodybuilder.setNickname(_nickname: "Player\(random)")
        }
        
    }
    
    func updatePlayer(uuid: String) {
        let params: Parameters = [
            "device_uuid": "\(uuid)",
            "level": bodybuilder.getLeveL(),
            "strength": bodybuilder.getStrength(),
            "nickname": bodybuilder.getNickname()
        ]
        
        Alamofire.request("http://orteedev.pl:3000/api/users/\(uuid)", method: .put, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
        }
    }
}

var httpRequest: Http = Http()
