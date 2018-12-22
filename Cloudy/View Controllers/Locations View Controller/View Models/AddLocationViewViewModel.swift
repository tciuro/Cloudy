//
//  AddLocationViewViewModel.swift
//  Cloudy
//
//  Created by Tito Ciuro on 12/19/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

class AddLocationViewViewModel {
    
    var hasLocations: Bool { return numberOfLocations > 0 }
    var numberOfLocations: Int { return _locations.value.count }
    var querying: Driver<Bool> { return _querying.asDriver() }
    var locations: Driver<[Location]> { return _locations.asDriver() }
    
    private let locationService: LocationService
    private let disposeBag = DisposeBag()
    private let _locations = BehaviorRelay<[Location]>(value: [])
    private let _querying = BehaviorRelay<Bool>(value: false)
    
    init(query: Driver<String>, locationService: LocationService) {
        self.locationService = locationService
        
        query
            .throttle(0.5)
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (addressString) in
                self?.geocode(addressString: addressString)
            })
            .disposed(by: disposeBag)
    }
    
    func location(at index: Int) -> Location? {
        guard index < numberOfLocations else { return nil }
        return _locations.value[index]
    }
    
    func viewModelForLocation(at index: Int) -> LocationRepresentable? {
        guard let location = location(at: index) else { return nil }
        return LocationsViewLocationViewModel(location: location.location, locationAsString: location.name)
    }
    
    private func geocode(addressString: String?) {
        guard let addressString = addressString, !addressString.isEmpty else {
            _locations.accept([])
            return
        }
        
        _querying.accept(true)
        
        locationService.geocode(addressString: addressString) { [weak self] (locations, error) in
            
            self?._querying.accept(false)
            self?._locations.accept(locations)

            if let error = error {
                print("Unable to forward geocode address. Reason: \(error)")
            }
            
        }
    }
    
}
