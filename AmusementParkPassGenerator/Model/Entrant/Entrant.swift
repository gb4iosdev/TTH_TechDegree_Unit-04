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
    func swipe(at checkpoint: Checkpoint) -> AccessFeedBack {
        var feedback = checkpoint.checkAreaAccess(self.pass)
        if let birthDayMessage = checkForBirthday() {
            feedback.accessFeedback += "\n" + birthDayMessage
        }
        return feedback
    }
    
    func checkForBirthday() -> String? {
        
        guard let entrantBirthdate = entrantInformation?.dateOfBirth else { return nil }
        
        //Celebrate birthday:
        let format = DateFormatter()
        format.dateFormat = "MM-dd"
        let formattedToday = format.string(from: Date())
        let formattedEntrantBirthDate = format.string(from: entrantBirthdate)
        
        if formattedToday == formattedEntrantBirthDate {
            return "Wish the entrant a happy birthday!!"
        } else {
            return nil
        }
    }
}
