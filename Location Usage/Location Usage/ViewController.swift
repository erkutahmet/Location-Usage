//
//  ViewController.swift
//  Location Usage
//
//  Created by erkut on 29.01.2024.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations[locations.count - 1]
        
        let latitude = lastLocation.coordinate.latitude
        let longitude = lastLocation.coordinate.longitude
        
        latitudeLabel.text = "Latitude  : \(lastLocation.coordinate.latitude)"
        longitudeLabel.text = "Longitude    : \(lastLocation.coordinate.longitude)"
        speedLabel.text = "Speed    : \(lastLocation.speed)"
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let area = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(area, animated: true)
        
        /*
        let pin = MKPointAnnotation()
        pin.coordinate = location
        pin.title = "\(longitude) - \(latitude)"
        pin.subtitle = "Location"
        mapView.addAnnotation(pin)
        */
        mapView.showsUserLocation = true
    }
}

