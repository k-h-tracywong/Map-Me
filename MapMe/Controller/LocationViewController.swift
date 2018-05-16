//
//  LocationViewController.swift
//  Map Me
//
//  Created by Tracy Wong on 2018-05-12.
//  Copyright © 2018 Tracy Wong. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let newPin = MKPointAnnotation()
    
    let GOOGLE_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/"
    let API_KEY = "AIzaSyCtT75ECjjSB40xupkfwJY93z2mOwUuAaQ"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        determineCurrentLocation()
        
    }
    

    func determineCurrentLocation() {

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let userLocation : CLLocation = locations[0] as CLLocation
        let lat : Double = userLocation.coordinate.latitude
        let lon : Double = userLocation.coordinate.longitude

        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        updateMapView(center: center)
        
        //HTTP request
        let params : [String : String] = ["lat" : String(lat), "lon" : String(lon), "radius" : "100", "APIKey" : API_KEY]
        
        
        //add drop pin
        let location = locations.last! as CLLocation
        
        newPin.coordinate = location.coordinate
        mapView.addAnnotation(newPin)
    }

    //didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //MARK: - Map View Updates
    /***************************************************************/
    
    func updateMapView(center: CLLocationCoordinate2D) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //triggers finding the list of POIs
    @IBAction func findPointOfInterestsAtStart(_ sender: UIButton) {
        
        //given current GPS location, use Google API to find a list of point of interests nearby
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    //updateListOfPOI
    
    
}

