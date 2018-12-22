//
//  LocationService.swift
//  Cloudy
//
//  Created by Tito Ciuro on 12/20/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import Foundation

protocol LocationService {
    
    typealias LocationserviceCompletionHandler = ([Location], Error?) -> Void
    
    func geocode(addressString: String?, completionHandler: @escaping LocationserviceCompletionHandler)
    
}
