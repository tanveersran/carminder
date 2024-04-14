//
//  SearchGaragesViewController.swift
//  CarMinder
//
//  Created by Default User on 4/14/24.
//

import UIKit
import MapKit

class SearchGaragesViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var  initialLocation : CLLocation?
    @IBOutlet var myMapView : MKMapView!
    @IBOutlet var tbLocEntered: UITextField!
   
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            myMapView.delegate = self
            myMapView.showsUserLocation = true
        
        title = "Nearby"
        }
        
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            if initialLocation == nil {
                initialLocation = location
                
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                myMapView.setRegion(region, animated: true)
                
                addNearbyCarGarages(at: location.coordinate)
            }
        }
        
        func addNearbyCarGarages(at coordinate: CLLocationCoordinate2D) {

            
            let garageCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude + 0.01, longitude: coordinate.longitude + 0.01)
            let garageAnnotation = MKPointAnnotation()
            garageAnnotation.coordinate = garageCoordinate
            garageAnnotation.title = "Car Garage"
            myMapView.addAnnotation(garageAnnotation)
        }
    }


