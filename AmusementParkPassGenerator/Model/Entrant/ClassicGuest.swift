//
//  ClassicGuest.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class ClassicGuest: Entrant {
    var pass: Pass
    var entrantInformation: EntrantInformation? = nil
    
    init() {
        self.pass = Pass (to: [Area.amusement],
                          rides: [.allRides]
        )
    }
}

