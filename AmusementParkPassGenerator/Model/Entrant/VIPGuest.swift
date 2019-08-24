//
//  VIPGuest.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class VIPGuest: Entrant {
    let pass: Pass
    var entrantInformation: EntrantInformation? = nil
    
    init() {
        self.pass = Pass (to: [Area.amusement],
                          rides: [.allRides, .skipLines],discounts: [.food(0.1), .merchandise(0.2)]
        )
    }
}
