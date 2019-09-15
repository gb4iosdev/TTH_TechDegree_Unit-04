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
    //Check area access at the checkpoint and return the response (AccessResponse).  Also check for entrant's birthday.
    func swipe(at checkpoint: Checkpoint) -> AccessResponse {
        var response = checkpoint.checkAreaAccess(self.pass)
        if let birthDayMessage = checkForBirthday() {
            response.accessResponseMessage += "\n\n" + birthDayMessage
        }
        return response
    }
    
    
    func checkForBirthday() -> String? {
        
        guard let entrantBirthdate = entrantInformation?.dateOfBirth else { return nil }
        
        //Set date format to month & day only in order to check for birthday
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
