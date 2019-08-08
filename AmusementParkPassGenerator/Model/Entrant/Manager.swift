//
//  Manager.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class Manager: Entrant {
    
    var entrantInformation: EntrantInformation?
    let pass: AmusementParkPass
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    var managementTier: ManagementTier
    
    init(entrantInformation information: EntrantInformation, managementTier tier: ManagementTier) throws {
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation(detail: "Missing Name information on Manager")
        }
        guard information.streetAddress != nil, information.city != nil, information.state != nil, information.zipCode != nil else {
            throw InformationError.missingAddressInformation(detail: "Missing Address information on Manager")
        }
        guard information.socialSecurityNumber != nil else {
            throw InformationError.missingSocialSecurityNumber(detail: "Missing Social Security Number on Manager")
        }
        
        self.entrantInformation = information
        self.managementTier = tier
        
        self.pass = AmusementParkPass(
            areaAccess: Set(Area.allCases),
            discounts: [.food : 0.25, .merchandise : 0.25],
            rideAccess: [.allRides]
        )
    }
}
