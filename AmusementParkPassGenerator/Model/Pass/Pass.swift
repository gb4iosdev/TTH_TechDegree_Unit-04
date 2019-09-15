//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class Pass {
    let areaAccess: Set<Area>
    var rideAccess: Set<RideAccess>
    var discounts: [Discount: Int]?
    let uuid: String
    let type: PassType
    
    //Check if ride access permissions are available - to assist with panel colouring
    var hasRideAccess: Bool { return !rideAccess.contains(.noRideAccess)}
    
    init(of type: PassType, to areas: Set<Area>, rides: Set<RideAccess>, discounts: [Discount : Int]? = nil) {
        areaAccess = areas
        rideAccess = rides
        self.discounts = discounts
        uuid = UUID().description
        self.type = type
    }
}

//MARK: - Helper Functions - for Pass details, and test panel results in PassTesterViewController (u{2022} is a bullet)
extension Pass {

    //Return ride access values in a bulleted list
    func formattedRideAccessForPass() -> String {
        return "\u{2022} " + rideAccess.map{ $0.rawValue }.joined(separator: "\n\u{2022} ")
    }
    
    //Return discount types and values in a bulleted list
    func formattedDiscountsForPass() -> String {
        if let discounts = self.discounts {
            var discountsString: String = ""
            for (discount, _) in discounts {
                discountsString += "\u{2022} \(formattedDiscount(for: discount))\n"
            }
            return discountsString
        } else {
            return ""
        }
    }
    
    //Return discount types and values for the test panel
    func formattedDiscount(for discountType: Discount) -> String {
        if let discounts = self.discounts, let value = discounts[discountType] {
            return " \(discountType.rawValue): \(value)%"
        } else {
            return "No \(discountType.rawValue)"
        }
    }
    
    //Check if discounts apply - to assist with panel colouring
    func hasDiscount(for discountType: Discount) -> Bool {
        if let discounts = self.discounts, discounts[discountType] != nil {
            return true
        } else {
            return false
        }
    }
}
