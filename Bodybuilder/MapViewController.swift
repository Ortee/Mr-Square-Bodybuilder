//
//  ViewController.swift
//  google-api
//
//  Created by Denis Olek on 05.01.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    var isInTrainingArea: Bool = false
    @IBOutlet weak var mapArea: GMSMapView!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var gymStatus: UILabel!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var gymNameLabel: UILabel!
    @IBOutlet weak var experienceView: UIView!
    @IBOutlet weak var _experienceLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var expRateLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelPercentLabel: UILabel!
    @IBOutlet weak var levelProgressBar: UIView!
    @IBOutlet weak var levelBar: UIProgressView!

    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: position.getLatitude(), longitude: position.getLongitude())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        mapArea.delegate = self
        
        
        // Create a map.
        let defaultCamera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                                                        longitude: defaultLocation.coordinate.longitude,
                                                                        zoom: zoomLevel)
        mapArea.camera = defaultCamera
        mapArea.isMyLocationEnabled = true
        mapArea.settings.myLocationButton = true
        mapArea.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // map style
        do {
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapArea.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapArea)
        mapArea.isHidden = true
    }
    
}

var queueTimer = Timer()
var timer = Timer()
// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate {
    func onTheGymAction() {
        bodybuilder.increaseExperiencePerSecond()
        experienceLabel.text = "\(bodybuilder.getExperience()) / \(bodybuilder.getExperienceForLevel(_level: bodybuilder.getLeveL()+1))"
    }
    
    func checkGymLocation() {
        if gymList.getGyms().count > 0 {
            queueTimer.invalidate()
            print("GYMS FOUND: \(gymList.getGyms().count)")
            for gym in gymList.getGyms() {
                print("Gym name: ", gym.getName())
                let position = CLLocationCoordinate2D(latitude: gym.getLatitude(), longitude: gym.getLongitude())
                let marker = GMSMarker(position: position)
                marker.icon = UIImage(named: "gym-marker")
                marker.title = gym.getName()
                marker.map = mapArea
            }
            // check bodybuilder is near gym
            let isNerarGym: Bool = bodybuilder.checkBodybuilderIsOnGym(_gymlist: gymList.getGyms(), _latitude: position.getLatitude(), _longitude: position.getLongitude())
            
            if(isNerarGym) {
                timer.invalidate()
                let currentGym: Gym = bodybuilder.checkGymName(_gymlist: gymList.getGyms(), _latitude: position.getLatitude(), _longitude: position.getLongitude())
                mapArea.isHidden = true
                trainButton.isHidden = false
                gymNameLabel.text = currentGym.getName()
                gymNameLabel.isHidden = false
                gymStatus.isHidden = true
                isInTrainingArea = true
                experienceView.isHidden = false
                _experienceLabel.isHidden = false
                experienceLabel.text = "\(bodybuilder.getExperience()) / \(bodybuilder.getExperienceForLevel(_level: bodybuilder.getLeveL()+1))"
                experienceLabel.isHidden = false
                expRateLabel.text = "\(bodybuilder.getExperienceIncreaseValue()) strength / sec"
                expRateLabel.isHidden = false
                levelLabel.text = "Level " + String(bodybuilder.getLeveL())
                levelLabel.isHidden = false
                levelPercentLabel.text = "\(Int(bodybuilder.getPercentExperienceToBar()*100))%"
                levelPercentLabel.isHidden = false
                levelBar.progress = bodybuilder.getPercentExperienceToBar()
                levelBar.isHidden = false
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTheGymAction), userInfo: nil, repeats: true)
            } else {
                timer.invalidate()
                mapArea.isHidden = false
                trainButton.isHidden = true
                gymNameLabel.isHidden = true
                gymStatus.isHidden = false
                isInTrainingArea = false
                experienceView.isHidden = true
                _experienceLabel.isHidden = true
                experienceLabel.isHidden = true
                expRateLabel.isHidden = true
                levelPercentLabel.isHidden = true
                levelLabel.isHidden = true
                levelBar.isHidden = true
            }
            print("GYMY HERE")
        } else {
            print("GYMOW BRAK")
        }
    }
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location.coordinate.latitude) \(location.coordinate.longitude)")
        
        position.setPosition(_latitude: location.coordinate.latitude, _longitude: location.coordinate.longitude)
        
        
        queueTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkGymLocation), userInfo: nil, repeats: true)
        
        // get Nerby Gyms
        gymList.getNerbyGyms(latitude: position.getLatitude(), longitude: position.getLongitude())
        //        timer.invalidate()
        
        let currentLocation: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                                          longitude: location.coordinate.longitude,
                                                                          zoom: zoomLevel)
//        if mapArea.isHidden {
//            mapArea.isHidden = false
//            mapArea.camera = currentLocation
//        } else {
//            mapArea.animate(to: currentLocation)
//        }
        
        if isInTrainingArea == true {
            mapArea.camera = currentLocation
        } else {
            mapArea.animate(to: currentLocation)
        }
        
    }
    
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapArea.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}
