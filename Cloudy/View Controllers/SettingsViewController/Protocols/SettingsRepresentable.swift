//
//  SettingsRepresentable.swift
//  Cloudy
//
//  Created by Tito Ciuro on 12/17/18.
//  Copyright © 2018 Cocoacasts. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    
    var text: String { get }
    var accessoryType: UITableViewCell.AccessoryType { get }
    
}
