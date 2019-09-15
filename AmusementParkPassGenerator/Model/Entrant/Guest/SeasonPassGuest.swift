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
        
        //Validate entrant's information per business rules:
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation(detail: "Missing Name information for Season Pass Guest")
        }
        guard information.streetAddress != nil, information.city != nil, information.state != nil, information.zipCode != nil else {
            throw InformationError.missingAddressInformation(detail: "Missing Address information for Season Pass Guest")
        }
        
        //Set the information
        self.entrantInformation = information
        
        //Create the Pass
        self.pass = Pass(of: .seasonPassGuestPass, to: [.amusement], rides: [.allRides, . skipLines], discounts: [.food : 10, .merchandise : 20])
    }
}
