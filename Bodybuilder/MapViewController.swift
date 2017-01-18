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
    @IBOutlet weak var gymStatus: UILabel!
    @IBOutlet weak var trainButton: UIButton!
    @IBOutlet weak var _trainButton: UIButton!
    @IBOutlet weak var gymNameLabel: UILabel!
    @IBOutlet weak var experienceView: UIView!
    @IBOutlet weak var _experienceLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var expRateLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelPercentLabel: UILabel!
    @IBOutlet weak var levelProgressBar: UIView!
    @IBOutlet weak var levelBar: UIProgressView!
    @IBOutlet weak var energyView: UIView!
    @IBOutlet weak var energyProgressBar: UIProgressView!
    @IBOutlet weak var energyPercentLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var _timeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func clickStartTraining(_ sender: Any) {
        trainingStarted = true
        trainingTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTraining), userInfo: nil, repeats: true)
        startTraining()
        trainButton.isHidden = true
        _trainButton.isHidden = false
    }
    @IBAction func clickStopTraining(_ sender: Any) {
        stopTraining()
        trainingStarted = false
    }
    

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
var trainingTimer = Timer()
var trainingStarted: Bool = false
// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate {
    
    func onTheGymAction() {
        bodybuilder.increaseExperiencePerSecond()
        experienceLabel.text = "\(bodybuilder.getExperience()) / \(bodybuilder.getExperienceForLevel(_level: bodybuilder.getLeveL()+1))"
    }
    
    func showGymView() {
        mapArea.isHidden = true
        trainButton.isHidden = false
        gymNameLabel.isHidden = false
        gymStatus.isHidden = true
        experienceView.isHidden = false
        _experienceLabel.isHidden = false
        experienceLabel.isHidden = false
        expRateLabel.isHidden = false
        levelLabel.isHidden = false
        levelPercentLabel.isHidden = false
        levelBar.isHidden = false
        energyProgressBar.isHidden = false
        energyView.isHidden = false
        energyLabel.isHidden = false
        energyPercentLabel.isHidden = false
        _timeLabel.isHidden = false
        timeLabel.isHidden = false
    }
    
    func hideGymView() {
        mapArea.isHidden = false
        trainButton.isHidden = true
        gymNameLabel.isHidden = true
        gymStatus.isHidden = false
        experienceView.isHidden = true
        _experienceLabel.isHidden = true
        experienceLabel.isHidden = true
        expRateLabel.isHidden = true
        levelPercentLabel.isHidden = true
        levelLabel.isHidden = true
        levelBar.isHidden = true
        energyProgressBar.isHidden = true
        energyView.isHidden = true
        energyLabel.isHidden = true
        energyPercentLabel.isHidden = false
        _timeLabel.isHidden = true
        timeLabel.isHidden = true
        _trainButton.isHidden = true
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> String {
        let hours = seconds / 3600
        let mins = (seconds % 3600) / 60
        let secs = (seconds % 3600) % 60

        return String(format:"%02i:%02i:%02i", hours, mins, secs)
    }
    
    func startTraining() {
        print("TRAINING STARTED")
        if bodybuilder.getEnergy() > 0 {
            bodybuilder.increaseExperiencePerSecond()
            bodybuilder.consumptionEnergy()
        } else {
            trainingStarted = false
            stopTraining()
        }
    }
    
    func stopTraining() {
        print("TRAINING STOPPED")
        trainingTimer.invalidate()
        trainButton.isHidden = false
        _trainButton.isHidden = true
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
            // check user is near gym
            let isNerarGym: Bool = bodybuilder.checkBodybuilderIsOnGym(_gymlist: gymList.getGyms(), _latitude: position.getLatitude(), _longitude: position.getLongitude())
            
            if(isNerarGym) {
                timer.invalidate()
                showGymView()
                isInTrainingArea = true
                let currentGym: Gym = bodybuilder.checkGymName(_gymlist: gymList.getGyms(), _latitude: position.getLatitude(), _longitude: position.getLongitude())
                
                gymNameLabel.text = currentGym.getName()
                
                levelLabel.text = "LEVEL " + String(bodybuilder.getLeveL())
                levelPercentLabel.text = "\(Int(bodybuilder.getPercentExperienceToBar()*100))%"
                print(bodybuilder.getPercentExperienceToBar())
                levelBar.progress = bodybuilder.getPercentExperienceToBar()
                experienceLabel.text = "\(bodybuilder.getExperience()) / \(bodybuilder.getExperienceForLevel(_level: bodybuilder.getLeveL()+1))"
                expRateLabel.text = "\(bodybuilder.getExperienceIncreaseValue()) strength / sec"
                
                if bodybuilder.getEnergy() > 0 {
                    energyPercentLabel.text = "\(Int(bodybuilder.getEnergyPercent()))%"
                    energyProgressBar.progress = bodybuilder.getEnergyPercent()/100
                    timeLabel.text = secondsToHoursMinutesSeconds(seconds: bodybuilder.getEnergy())
                } else {
                    energyPercentLabel.text = "0%"
                    energyProgressBar.progress = 0
                    timeLabel.text = "00:00:00"
                }
                
                
            } else {
                timer.invalidate()
                if trainingStarted {
                    stopTraining()
                }
                hideGymView()
                isInTrainingArea = false
            }
            print("USER IN GYM LOCATION")
        } else {
            print("USER NOT IN GYM LOCATION")
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
        
        let currentLocation: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                                          longitude: location.coordinate.longitude,
                                                                          zoom: zoomLevel)
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
