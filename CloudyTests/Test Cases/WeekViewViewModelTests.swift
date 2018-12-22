//
//  WeekViewViewModelTests.swift
//  CloudyTests
//
//  Created by Tito Ciuro on 12/17/18.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class WeekViewViewModelTests: XCTestCase {

    // MARK: - Properties

    var viewModel: WeekViewViewModel!

    // MARK: - Set Up & Tear Down

    override func setUp() {
        super.setUp()
        let data = loadStubFromBundle(withName: "darksky", extension: "json")
        do {
            let weatherData: WeatherData = try JSONDecoder.decode(data: data)
            viewModel = WeekViewViewModel(weatherDayData: weatherData.dailyData)
        } catch {
            XCTFail("Unable to initialize the viewModel with weather data.")
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Tests for Number of Sections

    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }

    // MARK: - Tests for Number of Days

    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }

    // MARK: - Tests for View Model for Index

    func testViewModelForIndex() {
        let weatherDayViewViewModel = viewModel.viewModel(for: 5)

        XCTAssertEqual(weatherDayViewViewModel.day, "Sat")
        print("\(weatherDayViewViewModel.date)")
        XCTAssertEqual(weatherDayViewViewModel.date, "Jul 15")
    }

}
