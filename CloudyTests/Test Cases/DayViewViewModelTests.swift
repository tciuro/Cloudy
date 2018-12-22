//
//  DayViewViewModelTests.swift
//  CloudyTests
//
//  Created by Tito Ciuro on 12/19/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class DayViewViewModelTests: XCTestCase {
    
    var viewModel: DayViewViewModel!
    
    override func setUp() {
        super.setUp()
        let data = loadStubFromBundle(withName: "darksky", extension: "json")
        do {
            let weatherData: WeatherData = try JSONDecoder.decode(data: data)
            viewModel = DayViewViewModel(weatherData: weatherData)
        } catch {
            XCTFail("Unable to initialize the viewModel with weather data.")
        }
    }
    
    override func tearDown() {
        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
        super.tearDown()
    }
    
    // MARK: - Tests for Time
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Tue, Jul 11")
    }
    
    func testTime_TwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        XCTAssertEqual(viewModel.time, "04:57 AM")
    }
    
    func testTime_TwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        XCTAssertEqual(viewModel.time, "04:57")
    }
    
    // MARK: - Tests for Summary
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Clear")
    }
    
    // MARK: - Tests for Temperature
    
    func testTemperature_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        XCTAssertEqual(viewModel.temperature, "44.5 ºF")
    }
    
    func testTemperature_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        XCTAssertEqual(viewModel.temperature, "6.9 ºC")
    }
    
    // MARK: - Tests for Wind Speed
    
    func testWindSpeed_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        XCTAssertEqual(viewModel.windSpeed, "6 MPH")
    }
    
    func testWindSpeed_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        print(viewModel.windSpeed)
        XCTAssertEqual(viewModel.windSpeed, "10 KPH")
    }
    
    // MARK: - Tests for Image
    
    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "clear-day")!.pngData()!
        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 236.0)
        XCTAssertEqual(viewModelImage!.size.height, 236.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
    
}
