//
//  ProjectDataSource.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 29-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Project listing for the contractor
struct ProjectDataSource {
    static let projects: [Int] = [
        1001,
        1002,
        1003,
        2001,
        2002
    ]
    
    //Project access areas per business rules
    static let accessAreas: [Int : Set<Area>] = [
        1001: [.amusement, .rideControl],
        1002: [.amusement, .rideControl, .maintenance],
        1003: [.amusement, .rideControl, .kitchen, .maintenance, .office],
        2001: [.office],
        2002: [.kitchen, . maintenance, . office]
    ]
}