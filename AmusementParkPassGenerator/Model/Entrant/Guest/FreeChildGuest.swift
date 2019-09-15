//
//  FreeChildGuest.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class FreeChildGuest: Entrant {
    
    let pass: Pass
    let entrantInformation: EntrantInformation?
    
    let childAgeThreshold = 5
    let yearDivisor: Double = 3600*24*365   //Number of seconds in a year
    
    init(entrantInformation information: EntrantInformation) throws {
        
        //Validate entrant's information per business rules:
        //Check entrant is less than or equal to 5 years old
        let currentDate = Date()
        let durationInSeconds = currentDate.timeIntervalSince(information.dateOfBirth)
        let ageOfEntrant = durationInSeconds / yearDivisor
        
        guard ageOfEntrant <= 5.0 else {
            throw InformationError.incorrectAge(detail: "Child Entrant must be less than 5 years old")
        }
        
        //Set the information
        self.entrantInformation = information
        
        //Create the Pass
        self.pass = Pass(of: .freeChildGuestPass, to: [Area.amusement], rides: [.allRides])
    }
}

