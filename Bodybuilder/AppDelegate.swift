//
//  AppDelegate.swift
//  Bodybuilder
//
//  Created by Denis Olek on 05.01.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyApjfp13AoYpE9-2ERwGlZzh-J-iLCpKEI")
        
        return true
    }
    
}
