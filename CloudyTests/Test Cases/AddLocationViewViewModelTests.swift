//
//  AddLocationViewViewModelTests.swift
//  CloudyTests
//
//  Created by Tito Ciuro on 12/20/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxCocoa
import RxBlocking
@testable import Cloudy

class AddLocationViewViewModelTests: XCTestCase {
    
    private class MockLocationService: LocationService {
        func geocode(addressString: String?, completionHandler: @escaping AddLocationViewViewModelTests.MockLocationService.LocationserviceCompletionHandler) {
            if let addressString = addressString, !addressString.isEmpty {
                let location = Location(name: "Brussels", latitude: 50.8503, longitude: 4.3517)
                completionHandler([location], nil)
            } else {
                completionHandler([], nil)
            }
        }
    }
    
    var viewModel: AddLocationViewViewModel!
    var scheduler: SchedulerType!
    var query: BehaviorRelay<String>!

    override func setUp() {
        super.setUp()
        
        query = BehaviorRelay<String>(value: "")
        
        let locationService = MockLocationService()
        
        viewModel = AddLocationViewViewModel(query: query.asDriver(), locationService: locationService)
        
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: -
    
    func testLocations_HasLocations() throws {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        query.accept("Brus")
        
        let result = try observable.skip(1).toBlocking().first()!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 1)
        
        let location = result.first!
        
        XCTAssertEqual(location.name, "Brussels")
    }
    
    func testLocations_NoLocations() throws {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        let result = try observable.toBlocking().first()!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 0)
    }
    
    func testLocationAtIndex_NonNil() throws {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        query.accept("Brus")
        
        _ = try observable.skip(1).toBlocking().first()!

        let result = viewModel.location(at: 0)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result!.name, "Brussels")
    }
    
    func testLocationAtIndex_Nil() throws {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        
        query.accept("Brus")
        
        _ = try observable.skip(1).toBlocking().first()!
        
        let result = viewModel.location(at: 1)
        
        XCTAssertNil(result)
    }

}
