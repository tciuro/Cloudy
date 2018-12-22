//
//  Geocoder.swift
//  Cloudy
//
//  Created by Tito Ciuro on 12/20/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import CoreLocation

class Geocoder: LocationService {
    
    private lazy var geocoder = CLGeocoder()
    
    func geocode(addressString: String?, completionHandler: @escaping ([Location], Error?) -> Void) {
        guard let addressString = addressString else {
            completionHandler([], nil)
            return
        }
        
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if let error = error {
                print("Unable to forward geocode address. Reason: \(error)")
                completionHandler([], nil)
                return
            }
            
            guard let placemarks = placemarks else {
                completionHandler([], nil)
                return
            }
            
            let locations = placemarks.compactMap({ (placemark) -> Location? in
                guard let name = placemark.name, let location = placemark.location else {
                    return nil
                }
                return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            })
            
            completionHandler(locations, nil)
        }
    }
}
