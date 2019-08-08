//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

protocol Entrant {
    var pass: AmusementParkPass { get }
    var entrantInformation: EntrantInformation? { get }
    var lastSwipeTimeStamp: [Area : Date]? { get set }
}

extension Entrant {
    
    mutating func processSwipeAt(_ area: Area)  {
        print("***SWIPE COMMENCED***")
        //Check if swiped too soon:
        if let lastSwipeTime = self.lastSwipeTimeStamp?[area], Date().timeIntervalSince(lastSwipeTime) < 5 {
            print("Can’t access same area within 5 seconds")
            print("***SWIPE FINISHED***")
            return
        }
        
        //Record the swipe:
        if var lastSwipeTimeStamp = self.lastSwipeTimeStamp {
            lastSwipeTimeStamp[area] = Date()
            self.lastSwipeTimeStamp = lastSwipeTimeStamp
        } else {
            lastSwipeTimeStamp = [area : Date()]
        }
        
        if self.pass.canAccessArea(area) {
            print("Entrant has access to area \(area.rawValue)")
            print("Ride access type/s: \(self.pass.rideAccess)")
            print("Discounts are: \(self.pass.printDiscounts())")
        } else {
            print("Entrant does not have access to \(area)")
        }
        
        //Celebrate birthday:
        if let entrantBirthdate = self.entrantInformation?.dateOfBirth {
            let format = DateFormatter()
            format.dateFormat = "MM-dd"
            let formattedToday = format.string(from: Date())
            let formattedEntrantBirthDate = format.string(from: entrantBirthdate)
            
            if formattedToday == formattedEntrantBirthDate {
                print("Wish the entrant a happy birthday!!")
            }
        }
        print("***SWIPE FINISHED***")
    }
}
