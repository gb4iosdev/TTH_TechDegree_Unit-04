//
//  Checkpoint.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 21-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

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
    
    private func accessPermitted(for pass: Pass) -> Bool {
        
        if self.checkpointType == .areaAccess, let area = self.area {
            return pass.areaAccess.contains(area)
        } else {
            return false
        }
    }
    
    func checkAreaAccess(_ pass: Pass) -> AccessFeedBack {
        
        guard swipeAllowed(for: pass) else {
            return AccessFeedBack(accessFeedback: "Can’t use the same pass within \(minimumSwipeInterval) seconds", accessIsGranted: false)
        }
        
        if accessPermitted(for: pass), let area = self.area?.rawValue {
            return AccessFeedBack(accessFeedback: "Pass provides access to the \(area)", accessIsGranted: true)
        } else {
            return AccessFeedBack(accessFeedback: "No access provided", accessIsGranted: false)
        }
            
//        case .ride:             //Print ride access types:
//            print("Entrant has the following ride access:\n")
//            for rideAccessType in pass.rideAccess {
//                print(rideAccessType)
//            }
//
//        case .register:     //Print discounts
//            if let discounts = pass.discounts {
//                print("Entrant is eligible for the following discounts\n")
//                for (discount, value) in discounts {
//                    print("\(discount.rawValue) is: \(value)%")
//                }
//            } else {
//                print("Entrant is not eligible for any discounts")
//            }
//        }
    }
}
