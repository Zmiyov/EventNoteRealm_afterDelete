//
//  MapViewController.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 20.09.2022.
//

import UIKit
import MapKit
import GooglePlaces

protocol MapKitViewControllerDelegate {
    func mapKitViewController(_ controller: MapKitViewController, didSelect locationData: LocationDataModel)
}

class MapKitViewController: UIViewController {

    let mapView = MKMapView()
    
    var locationData = LocationDataModel()
    let locationManager = CLLocationManager()
    
    var delegate: MapKitViewControllerDelegate?
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resaultView: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Places"
        
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveBarButton
        configureMapView()
        
        locationManager.delegate = self
        locationManagerDidChangeAuthorization(locationManager)
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        configureSearchController()
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.searchController = searchController

        
        self.extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = .top
        definesPresentationContext = true
        
        updateSaveButtonState()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = CGRect(x: 0,
                               y: view.safeAreaInsets.top,
                               width: view.frame.size.width,
                               height: view.frame.size.height - view.safeAreaInsets.top)
    }
    
    @objc func saveButtonTapped() {
        self.delegate?.mapKitViewController(self, didSelect: locationData)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = locationData.name != nil
        navigationItem.rightBarButtonItem!.isEnabled = shouldEnableSaveButton
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.setUserTrackingMode(.follow, animated:true)
        let myLocation = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 50.4421291,
                                                longitude: locationManager.location?.coordinate.longitude ?? 30.5446104)
        mapView.camera = MKMapCamera(lookingAtCenter: myLocation, fromEyeCoordinate: myLocation, eyeAltitude: 15000)
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
    }

}

extension MapKitViewController: UISearchResultsUpdating {
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
        locationData.name = name
        locationData.longitude = place.coordinate.longitude
        locationData.latitude = place.coordinate.latitude
        
        let placePin = MKPointAnnotation()
        placePin.title = place.formattedAddress
        placePin.coordinate = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        mapView.addAnnotation(placePin)
        
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        
        print("\(place.coordinate.latitude)")
        print("\(place.coordinate.longitude)")
        
        let target = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        mapView.camera = MKMapCamera(lookingAtCenter: target, fromDistance: 3000.0, pitch: 0, heading: 0)
        
        updateSaveButtonState()
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print(error)
    }
    
}

extension MapKitViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            return
        case .authorizedAlways:
            locationManager.requestLocation()
            return
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            return
        @unknown default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let target = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
        let target = CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234)
//        googleMap.camera = GMSCameraPosition(target: target, zoom: 10, bearing: 0, viewingAngle: 0)
        mapView.camera = MKMapCamera(lookingAtCenter: target, fromDistance: 2000.0, pitch: 0, heading: 0)

//        let marker = GMSMarker()
//        marker.position = target
//        marker.title = "Hi"
//        marker.snippet = "I'm here"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
