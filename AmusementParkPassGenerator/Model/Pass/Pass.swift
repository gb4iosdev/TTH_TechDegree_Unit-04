//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class Pass {
    var areaAccess: Set<Area>
    var rideAccess: Set<RideAccessType>
    var discounts: [Discount]?
    var uuid: String
    
    init(to areas: Set<Area>, rides: Set<RideAccessType>, discounts:[Discount]? = nil) {
        areaAccess = areas
        rideAccess = rides
        self.discounts = discounts
        uuid = UUID().description
    }
}
