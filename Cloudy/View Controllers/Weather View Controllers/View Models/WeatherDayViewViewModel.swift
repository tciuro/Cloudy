//
//  WeatherDayViewViewModel.swift
//  Cloudy
//
//  Created by Tito Ciuro on 12/17/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

struct WeatherDayViewViewModel: WeatherDayRepresentable {
    
    let weatherDayData: WeatherDayData
    
    private let dayFormatter = DateFormatter()
    private let dateFormatter = DateFormatter()

    var day: String {
        dayFormatter.dateFormat = "EEE"
        return dayFormatter.string(from: weatherDayData.time)
    }
    
    var date: String {
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: weatherDayData.time)
    }
    
    var temperature: String {
        let min = format(temperature: weatherDayData.temperatureMin)
        let max = format(temperature: weatherDayData.temperatureMax)
        return "\(min) - \(max)"
    }
    
    var windSpeed: String {
        let windspeed = weatherDayData.windSpeed
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f MPH", windspeed)
        case .metric:
            return String(format: "%.f KPH", windspeed.toKPH())
        }
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(withName: weatherDayData.icon)
    }
    
    // MARK: - Private -
    
    private func format(temperature: Double) -> String {
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.0f ºF", temperature)
        case .celsius:
            return String(format: "%.0f ºC", temperature.toCelsius())
        }
    }

}
