//
//  MapAppOpt.swift
//  EventNote
//
//  Created by Vladimir Pisarenko on 24.09.2022.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

public enum MapAppOpt {
    case AppleMaps
    case GoogleMaps
    case Waze
    
    public var appName: String {
        switch self {
        case .AppleMaps:
            return "Apple Maps"
        case .GoogleMaps:
            return "Google Maps"
        case .Waze:
            return "Waze"
        }
    }
    public var baseUrl: String {
        switch self {
        case .AppleMaps:
            return "http://maps.apple.com"
        case .GoogleMaps:
            return "comgooglemaps://"
        case .Waze:
            return "waze://"
        }
    }
    
    public static let allApps: [MapAppOpt] = [.AppleMaps, .GoogleMaps, .Waze]
    
    public static var avaliableApps: [MapAppOpt] {
        return self.allApps.filter { app in app.available }
    }
    
    public var url: URL? {
        return URL(string: self.baseUrl)
    }
    
    public var available: Bool {
        guard let url = self.url else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    public func mapUrlString(coordinate: CLLocationCoordinate2D, name: String = "Destination") -> String {
        var urlString = self.baseUrl
        
        switch self {
        case .AppleMaps:
            urlString.append("?q=\(coordinate.latitude), \(coordinate.longitude)=d&t=h")
        case .GoogleMaps:
            urlString.append("?saddr=&daddr=\(coordinate.latitude),\(coordinate.longitude)&directionsmode=driving")
        case .Waze:
            urlString.append("?ll=\(coordinate.latitude),\(coordinate.longitude)&navigate=yes")
        }
        
        let urlWithPercentEscapes = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
        
        return urlWithPercentEscapes
    }
    
    public func directionsUrl(coordinate: CLLocationCoordinate2D, name: String = "Destination") -> URL? {
        let urlString = self.mapUrlString(coordinate: coordinate, name: name)
        return URL(string: urlString)
    }
    
    public func openWithMap(coordinate: CLLocationCoordinate2D, name: String = "Destination", completion: ((Bool) -> Swift.Void)? = nil) {
        if self == .AppleMaps {
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
            mapItem.name = name
            
            let success = mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
            
            completion?(success)
        }
        guard let url = self.directionsUrl(coordinate: coordinate, name: name) else {
            completion?(false)
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:]) { success in
//                print("Open \(url.absoluteString): \(success)")
                completion?(success)
            }
        } else {
            let success = UIApplication.shared.openURL(url)
            completion?(success)
        }
    }
    
    public static func mapsAlertController(coordinate: CLLocationCoordinate2D, name: String = "Destination", title: String = "Directions Using", message: String? = nil, completion: ((Bool) -> ())? = nil) -> UIAlertController {
        let mapsAlertView = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for navigationApp in MapAppOpt.avaliableApps {
            let action = UIAlertAction(title: navigationApp.appName, style: .default) { action in
                navigationApp.openWithMap(coordinate: coordinate, name: name, completion: completion)
            }
            mapsAlertView.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Dismiss".localized(), style: .cancel) { action in
            completion?(false)
        }
        mapsAlertView.addAction(cancelAction)
        return mapsAlertView
    }
}
