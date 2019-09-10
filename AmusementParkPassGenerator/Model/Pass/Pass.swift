//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class Pass {
    let areaAccess: Set<Area>
    let rideAccess: Set<RideAccess>
    let discounts: [Discount]?
    let uuid: String
    let type: PassType
    
    init(of type: PassType, to areas: Set<Area>, rides: Set<RideAccess>, discounts:[Discount]? = nil) {
        areaAccess = areas
        rideAccess = rides
        self.discounts = discounts
        uuid = UUID().description
        self.type = type
    }
}
