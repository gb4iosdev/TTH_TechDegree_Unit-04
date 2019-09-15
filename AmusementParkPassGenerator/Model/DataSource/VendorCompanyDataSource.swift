//
//  VendorCompanyDataSource.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 29-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Vendor company access areas per business rules:
struct VendorCompanyDataSource {
    static let accessAreas: [VendorCompany : Set<Area>] = [
        .acme : [.kitchen],
        .orkin : [.amusement, .rideControl, .kitchen],
        .fedex : [.maintenance, .office],
        .nwElectrical : [.amusement, .rideControl, .kitchen, .maintenance, .office]
    ]
}
