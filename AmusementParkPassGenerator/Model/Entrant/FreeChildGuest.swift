//
//  FreeChildGuest.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class FreeChildGuest: Entrant {
    
    let pass: AmusementParkPass
    let entrantInformation: EntrantInformation?
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    let childAgeThreshold = 5
    let yearDivisor: Double = 3600*24*365   //Number of seconds in a year
    
    init(entrantInformation information: EntrantInformation) throws {
        
        //Check entrant is less than or equal to 5 years old
        let currentDate = Date()
        let durationInSeconds = currentDate.timeIntervalSince(information.dateOfBirth)
        let ageOfEntrant = durationInSeconds / yearDivisor
        
        print("Age of entrant is: \(ageOfEntrant)")
        
        guard ageOfEntrant <= 5.0 else {
            throw InformationError.incorrectAge(detail: "Child Entrant must be over 5 years old")
        }
        
        self.entrantInformation = information
        
        self.pass = AmusementParkPass(
            areaAccess: [Area.amusement],
            discounts: nil,
            rideAccess: [.allRides]
        )
    }
}

