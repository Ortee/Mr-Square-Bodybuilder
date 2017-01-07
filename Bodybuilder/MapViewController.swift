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
    @IBOutlet weak var mapArea: GMSMapView!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var gymStatus: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
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
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapArea)
        mapArea.isHidden = true
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        gymList.getNerbyGyms(latitude: mapArea.camera.target.latitude, longitude: mapArea.camera.target.longitude)
        for gym in gymList.getGyms() {
            print("Gym name: ", gym.getName())
            let position = CLLocationCoordinate2D(latitude: gym.getLatitude(), longitude: gym.getLongitude())
            let marker = GMSMarker(position: position)
            marker.title = gym.getName()
            marker.map = mapArea
        }
    }
}

// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate {
    func onTheGymAction() {
        bodybuilder.increaseStrength()
        strengthLabel.text = String(bodybuilder.getStrength())
    }
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        position.setPosition(_latitude: location.coordinate.latitude, _longitude: location.coordinate.longitude)
        latitudeLabel.text = String(position.getLatitude())
        longitudeLabel.text = String(position.getLongitude())
        
        // get Nerby Gyms
        gymList.getNerbyGyms(latitude: position.getLatitude(), longitude: position.getLongitude())
        // check bodybuilder is near gym
        let isNerarGym: Bool = bodybuilder.checkBodybuilderIsOnGym(_gymlist: gymList.getGyms(), _latitude: position.getLatitude(), _longitude: position.getLongitude())
        var timer = Timer()
        
        if(isNerarGym) {
            timer.invalidate()
            gymStatus.text = "You are on the gym now."
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(onTheGymAction), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            gymStatus.text = "You aren't on the gym now."
        }
        
        for gym in gymList.getGyms() {
            print("Gym name: ", gym.getName())
            let position = CLLocationCoordinate2D(latitude: gym.getLatitude(), longitude: gym.getLongitude())
            let marker = GMSMarker(position: position)
            marker.title = gym.getName()
            marker.map = mapArea
        }
        
        let currentLocation: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                                          longitude: location.coordinate.longitude,
                                                                          zoom: zoomLevel)
        
        if mapArea.isHidden {
            mapArea.isHidden = false
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
