//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

protocol Pass {
    var areaAccess: Set<Area> { get }
    var discounts: [DiscountOn : Double]? { get }
    var rideAccess: Set<RideAccessType> { get }
}
