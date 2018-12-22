//
//  WeatherDayViewViewModelTests.swift
//  CloudyTests
//
//  Created by Tito Ciuro on 12/17/18.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class WeatherDayViewViewModelTests: XCTestCase {

    // MARK: - Properties

    var viewModel: WeatherDayViewViewModel!

    // MARK: - Set Up & Tear Down

    override func setUp() {
        super.setUp()
        let data = loadStubFromBundle(withName: "darksky", extension: "json")
        do {
            let weatherData: WeatherData = try JSONDecoder.decode(data: data)
            viewModel = WeatherDayViewViewModel(weatherDayData: weatherData.dailyData[5])
        } catch {
            XCTFail("Unable to initialize the viewModel with weather data.")
        }
    }

    override func tearDown() {
        super.tearDown()

        // Reset User Defaults
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
    }

    // MARK: - Tests for Day

    func testDay() {
        XCTAssertEqual(viewModel.day, "Sat")
    }

    // MARK: - Tests for Date

    func testDate() {
        XCTAssertEqual(viewModel.date, "Jul 15")
    }

    // MARK: - Tests for Temperature

    func testTemperature_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)

        XCTAssertEqual(viewModel.temperature, "37 ºF - 47 ºF")
    }

    func testTemperature_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)

        XCTAssertEqual(viewModel.temperature, "3 ºC - 8 ºC")
    }

    // MARK: - Tests for Wind Speed

    func testWindSpeed_Imperial() {
        let unitsNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)

        XCTAssertEqual(viewModel.windSpeed, "1 MPH")
    }

    func testWindSpeed_Metric() {
        let unitsNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitsNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)

        XCTAssertEqual(viewModel.windSpeed, "2 KPH")
    }

    // MARK: - Tests for Image

    func testImage() {
        let viewModelImage = viewModel.image
        let imageDataViewModel = viewModelImage!.pngData()!
        let imageDataReference = UIImage(named: "cloudy")!.pngData()!

        XCTAssertNotNil(viewModelImage)
        XCTAssertEqual(viewModelImage!.size.width, 236.0)
        XCTAssertEqual(viewModelImage!.size.height, 172.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }

}
