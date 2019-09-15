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
        
        //Create the Pass
        self.pass = Pass(of: .vipGuestPass, to: [Area.amusement],
                         rides: [.allRides, .skipLines], discounts: [.food : 10, .merchandise : 20])
    }
}
