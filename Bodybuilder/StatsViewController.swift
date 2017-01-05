//
//  ViewController.swift
//  Bodybuilder
//
//  Created by Mateusz Oracz on 15.12.2016.
//  Copyright © 2016 BatoregoTeam. All rights reserved.
//

import UIKit
import CoreLocation

class StatsViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    @IBOutlet var gpsX: UILabel!
    @IBOutlet var gpsY: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var location: CLLocation! {
        didSet {
            gpsX.text = String(location.coordinate.latitude)
            gpsY.text = String(location.coordinate.longitude)
        }
    }
    
    func checkCoreLocationPermission() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .restricted {
            print("UNAUTHORIZED GPS LOCALIZATION")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        locationManager.stopUpdatingLocation()
        
    }
    
    @IBAction func gpsUpdate(_ sender: AnyObject) {
        locationManager.startUpdatingLocation()
    }
    
    
}
