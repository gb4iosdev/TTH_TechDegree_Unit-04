//
//  VIPGuest.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class VIPGuest: Entrant {
    
    let pass: AmusementParkPass
    var entrantInformation: EntrantInformation? = nil
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    init() {
        self.pass = AmusementParkPass(
            areaAccess: [Area.amusement],
            discounts: [.food : 0.1, .merchandise : 0.2],
            rideAccess: [.allRides, .skipLines]
        )
    }
}
