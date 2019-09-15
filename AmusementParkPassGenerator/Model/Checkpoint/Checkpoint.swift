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
    
    convenience init(ofType: CheckpointType, in area: Area? = nil) {
        self.init(checkpointType: ofType)
        self.area = area

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
        
        //return true if the checkpoint has an area and it's in the pass's allowable areas
        if self.checkpointType == .areaAccess, let area = self.area {
            return pass.areaAccess.contains(area)
        } else {
            return false
        }
    }
    
    func checkAreaAccess(_ pass: Pass) -> AccessResponse {
        
        //Check swipe frequency
        guard swipeAllowed(for: pass) else {
            return AccessResponse(accessResponseMessage: "Can’t use the same pass within \(minimumSwipeInterval) seconds", accessIsGranted: false)
        }
        
        //Check access permission
        if accessPermitted(for: pass), let area = self.area?.rawValue {
            return AccessResponse(accessResponseMessage: "Pass provides access to the \(area)", accessIsGranted: true)
        } else {
            return AccessResponse(accessResponseMessage: "No access provided", accessIsGranted: false)
        }
    }
}
