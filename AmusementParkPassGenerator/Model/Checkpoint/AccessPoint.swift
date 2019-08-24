//
//  AccessPoint.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 21-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class AccessPoint: Checkpoint {
    let area: Area
    init (for area: Area) {
        self.area = area
    }
    
    func swipe(_ pass: Pass) {
        if pass.areaAccess.contains(self.area) {
            print("Entrant has access to \(self.area) area")
        } else {
            print("Entrant denied access to \(self.area) area")
        }
        checkPassForBirthday(pass)
    }
}
