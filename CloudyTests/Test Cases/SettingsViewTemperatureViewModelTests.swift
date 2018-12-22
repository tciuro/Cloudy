//
//  SettingsViewTemperatureViewModelTests.swift
//  CloudyTests
//
//  Created by Tito Ciuro on 12/17/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsViewTemperatureViewModelTests: XCTestCase {
    
    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
        super.tearDown()
    }
    
    // MARK: - Tests for Text
    
    func testText_Fahrenheit() {
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.text, "Fahrenheit")
    }
    
    func testText_Celsius() {
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.text, "Celsius")
    }
    
    // MARK: - Tests for Accessory Type
    
    func testAccessoryType_Fahrenheit_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.checkmark)
    }
    
    func testAccessoryType_Fahrenheit_Celsius() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.none)
    }
    
    func testAccessoryType_Celsius_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.none)
    }
    
    func testAccessoryType_Celsius_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.accessoryType, UITableViewCell.AccessoryType.checkmark)
    }
    
}
