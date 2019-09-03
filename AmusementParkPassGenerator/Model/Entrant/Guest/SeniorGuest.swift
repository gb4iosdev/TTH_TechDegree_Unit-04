//
//  SeniorGuest.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 29-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class seniorGuest: Entrant {
    
    var entrantInformation: EntrantInformation?
    let pass: Pass
    
    init(entrantInformation information: EntrantInformation) throws {
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation(detail: "Missing Name information for Senior Guest")
        }
        
        self.entrantInformation = information
        self.pass = Pass(to: [.amusement], rides: [.allRides, . skipLines], discounts: [.food(0.1), .merchandise(0.1)])
    }
}


