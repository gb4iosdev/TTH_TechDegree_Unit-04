//
//  Checkpoint.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 21-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum CheckpointType {
    case areaAccess
    case ride
    case register
}

class Checkpoint {
    let checkpointType: CheckpointType
    var area: Area?
    typealias PassID = String
    let minimumSwipeInterval = 5.0
    var swipeHistory: [PassID : Date] = [:]
    
    init(checkpointType type: CheckpointType) {
        self.checkpointType = type
    }
    
    convenience init(ofType: CheckpointType, inArea: Area? = nil) {
        self.init(checkpointType: ofType)
        self.area = inArea

    }
    
    func swipeAllowed(for pass: Pass) -> Bool {
        
        //Check if swiped too soon:
        
        if let lastSwipeTime = swipeHistory[pass.uuid], Date().timeIntervalSince(lastSwipeTime) < minimumSwipeInterval {
            return false
        }  else {
            //Record the swipe:
            swipeHistory[pass.uuid] = Date()
            return true
        }
    }
    
    func checkPassEntitlements(_ pass: Pass) {
        
        guard swipeAllowed(for: pass) else {
            print("Can’t use the same pass within \(minimumSwipeInterval) seconds")
            return
        }
        
        switch self.checkpointType {
            
        case .areaAccess:          //Print Area Access
            if let thisArea = area, pass.areaAccess.contains(thisArea) {
                print("Entrant has access to \(thisArea) area")
            } else {
                print("Entrant does not have access to this area")
            }
            
        case .ride:             //Print ride access types:
            print("Entrant has the following ride access:\n")
            for rideAccessType in pass.rideAccess {
                print(rideAccessType)
            }
            
        case .register:     //Print discounts
            if let discounts = pass.discounts {
                print("Entrant is eligible for the following discounts\n")
                for discount in discounts {
                    print("Discount on \(discount) is: \(discount.value() * 100)%")
                }
            } else {
                print("Entrant is not eligible for any discounts")
            }
        }
    }
}
