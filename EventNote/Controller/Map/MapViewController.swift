//
//  MapViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 20.09.2022.
//

import UIKit
import MapKit
import GooglePlaces

class MapKitViewController: UIViewController, UISearchResultsUpdating {

    let mapView = MKMapView()
    
    var locationData: LocationDataModel?
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resaultView: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Places Apple"
        view.addSubview(mapView)
        mapView.setUserTrackingMode(.follow, animated:true)
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        
        navigationController?.navigationBar.isTranslucent = false
        searchController?.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        
        
        // This makes the view area include the nav bar even though it is opaque.
        // Adjust the view placement down.
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top)
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                print(places)
            case .failure(let error):
                print("In switch", error)
            }
        }
    }
}

extension MapKitViewController: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        
        searchController?.isActive = false
        guard let name = place.name else { return }
        locationData?.name = name
        locationData?.longitude = place.coordinate.longitude
        locationData?.latitude = place.coordinate.latitude
        
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        print("\(place.coordinate.longitude)")
        print("\(place.coordinate.latitude)")
        
        let target = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
//        googleMap.camera = GMSCameraPosition(target: target, zoom: 15, bearing: 0, viewingAngle: 0)
        mapView.camera = MKMapCamera(lookingAtCenter: target, fromDistance: 2000.0, pitch: 0, heading: 0)
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print(error)
    }
    
}

