//
//  VehicleExpensesViewController.swift
//  CarMinder
//
//  Created by Birarpanjot Singh on 4/12/24.
//  This controller is used to search for nearby garages and show them on the map.
//

import UIKit
import MapKit

class SearchGaragesViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {

    var locationManager = CLLocationManager()
    var initialLocation: CLLocation?
    @IBOutlet var myMapView: MKMapView!
    @IBOutlet var searchBar: UISearchBar!
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        myMapView.delegate = self
        myMapView.showsUserLocation = true
        
        searchBar.delegate = self
        searchBar.placeholder = "Search for nearby garages"
        
        searchNearbyGarages(for: "car repair")
        
        title = "Nearby Garages"
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        if initialLocation == nil {
            initialLocation = location

            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10, longitudinalMeters: 10)
            myMapView.setRegion(region, animated: true)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        searchNearbyGarages(for: query)
        searchBar.resignFirstResponder()
    }

    func searchNearbyGarages(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = myMapView.region

        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                print("Error searching: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            // Add annotations for search results
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                self.myMapView.addAnnotation(annotation)
            }

            self.myMapView.setRegion(response.boundingRegion, animated: true)


        }
    }
}
