//
//  WeatherDayRepresentable.swift
//  Cloudy
//
//  Created by Tito Ciuro on 12/17/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

protocol WeatherDayRepresentable {
    
    var day: String { get }
    var date: String { get }
    var image: UIImage? { get }
    var windSpeed: String { get }
    var temperature: String { get }
    
}
