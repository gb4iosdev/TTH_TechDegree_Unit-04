//
//  RideTurnstile.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 21-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class RideTurnstile: Checkpoint {
    
    typealias PassID = Int
    let minimumSwipeInterval = 5.0
    var swipeHistory: [PassID : Date] = [:]
    
    
    func swipe(_ pass: Pass) {
        
        //Check if swiped too soon:
        let passID = ObjectIdentifier(pass).hashValue
        
        if let lastSwipeTime = swipeHistory[passID], Date().timeIntervalSince(lastSwipeTime) < minimumSwipeInterval {
            print("Can’t access same ride within 5 seconds")
            return
        } else {
            //Record the swipe:
            swipeHistory[passID] = Date()
            
            //Print ride access types:
            print("Entrant has the following ride access:\n")
            for rideAccessType in pass.rideAccess {
                print(rideAccessType)
            }
            
            checkPassForBirthday(pass)
        }
    }
}
