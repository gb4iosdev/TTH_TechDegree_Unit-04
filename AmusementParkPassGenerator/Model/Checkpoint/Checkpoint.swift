//
//  Checkpoint.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 21-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

protocol Checkpoint {
    func swipe(_ pass: Pass)
}

extension Checkpoint {
    
    func checkPassForBirthday(_ pass: Pass) {
        //Celebrate birthday:
        if let entrantBirthdate = pass.entrantDateOfBirth {
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
