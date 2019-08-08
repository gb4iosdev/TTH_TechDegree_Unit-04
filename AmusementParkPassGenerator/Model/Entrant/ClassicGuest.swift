//
//  ClassicGuest.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class ClassicGuest: Entrant {
    var pass: AmusementParkPass
    var entrantInformation: EntrantInformation? = nil
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    init() {
        self.pass = AmusementParkPass(
            areaAccess: [Area.amusement],
            discounts: nil,
            rideAccess: [.allRides]
        )
    }
}
