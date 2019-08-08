//
//  AmusementParkPass.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

struct AmusementParkPass: Pass {
    var areaAccess: Set<Area>
    var discounts: [DiscountOn : Double]?
    var rideAccess: Set<RideAccessType>
    
    func canAccessArea(_ area: Area) -> Bool {
        return self.areaAccess.contains(area)
    }
    
    func canAccessRide(_ ride: RideAccessType) -> Bool {
        return self.rideAccess.contains(ride)
    }
    
    func printDiscounts() {
        if let discounts = self.discounts {
            for (key, value) in discounts {
                print("Discount on \(key) is: \(value * 100)%")
            }
        }
    }
}
