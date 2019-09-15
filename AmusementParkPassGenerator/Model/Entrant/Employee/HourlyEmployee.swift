//
//  HourlyEmployee.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class HourlyEmployee: Entrant {
    
    var entrantInformation: EntrantInformation?
    let pass: Pass
    
    init(ofType type: HourlyEmployeeType, entrantInformation information: EntrantInformation) throws {
        
        //Validate entrant's information per business rules:
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation(detail: "Missing Name information on Hourly Employee")
        }
        guard information.streetAddress != nil, information.city != nil, information.state != nil, information.zipCode != nil else {
            throw InformationError.missingAddressInformation(detail: "Missing Address information on Hourly Employee")
        }
        guard information.socialSecurityNumber != nil else {
            throw InformationError.missingSocialSecurityNumber(detail: "Missing Social Security Number on Hourly Employee")
        }
        
        //Set the information
        self.entrantInformation = information
        
        //Create Area access information based on the hourly empoloyee's sub type.
        var accessAreas: Set<Area> {
            switch type {
            case .foodServices: return [.amusement, .kitchen]
            case .rideServices: return [.amusement, .rideControl]
            case .maintenance: return [.amusement, .kitchen, .rideControl, .maintenance]
            }
        }
        
        //Create the Pass
        self.pass = Pass(of: .hourlyEmployeePass, to: accessAreas, rides: [.allRides],
                         discounts: [.food :15, .merchandise :25])
    }
}

