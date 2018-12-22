//
//  XCTestCase.swift
//  CloudyTests
//
//  Created by Tito Ciuro on 12/19/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import XCTest

extension XCTestCase {

    func loadStubFromBundle(withName name: String, extension anExtension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: anExtension)
        //swiftlint:disable:next force_try
        return try! Data(contentsOf: url!)
    }
    
}
