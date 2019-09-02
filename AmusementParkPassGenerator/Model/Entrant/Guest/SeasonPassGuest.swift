//
//  SeasonPassGuest.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 29-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class SeasonPassGuest: Entrant {
    
    var entrantInformation: EntrantInformation?
    let pass: Pass
    
    init(entrantInformation information: EntrantInformation) throws {
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation(detail: "Missing Name information for Season Pass Guest")
        }
        guard information.streetAddress != nil, information.city != nil, information.state != nil, information.zipCode != nil else {
            throw InformationError.missingAddressInformation(detail: "Missing Address information for contractor")
        }
        
        self.entrantInformation = information
        self.pass = Pass(to: [.amusement], rides: [.allRides, . skipLines], discounts: [.food(0.1), .merchandise(0.2)])
    }
}
