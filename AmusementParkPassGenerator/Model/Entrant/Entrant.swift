//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

protocol Entrant {
    var pass: Pass { get }
    var entrantInformation: EntrantInformation? { get }
}

extension Entrant {
    func swipe(at checkpoint: Checkpoint) {
        checkpoint.checkPassEntitlements(self.pass)
        checkForBirthday()
    }
    
    func checkForBirthday() {
        //Celebrate birthday:
        if let entrantBirthdate = entrantInformation?.dateOfBirth {
            let format = DateFormatter()
            format.dateFormat = "MM-dd"
            let formattedToday = format.string(from: Date())
            let formattedEntrantBirthDate = format.string(from: entrantBirthdate)
            
            if formattedToday == formattedEntrantBirthDate {
                print("Wish the entrant a happy birthday!!")
            }
        }
    }
}
