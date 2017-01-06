//
//  ViewController.swift
//  google-api
//
//  Created by Denis Olek on 05.01.2017.
//  Copyright © 2017 Denis Olek. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    @IBOutlet weak var mapArea: GMSMapView!
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: -33.8523341, longitude: 151.2106085)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MAP AREA: ", mapArea)
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
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
}

// Delegates to handle events for the location manager.
extension MapViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
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
