//
//  OnlineViewController.swift
//  Bodybuilder
//
//  Created by Denis Olek on 25.01.2017.
//  Copyright © 2017 BatoregoTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OnlineViewController: UIViewController {

    @IBAction func refresh(_ sender: Any) {
        Alamofire.request("http://localhost:3000/api/users").responseJSON { response in
            debugPrint(response)

            let json = JSON(data: response.data!)
            
            print("JSON\(json)")
            
            let test = json[0]["device_uuid"].stringValue
            
            print("test: \(test)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
