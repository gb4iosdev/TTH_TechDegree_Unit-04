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
    let rideAccess: Set<RideAccess>
    let discounts: [Discount]?
    let uuid: String
    let type: PassType
    
    init(of type: PassType, to areas: Set<Area>, rides: Set<RideAccess>, discounts:[Discount]? = nil) {
        areaAccess = areas
        rideAccess = rides
        self.discounts = discounts
        uuid = UUID().description
        self.type = type
    }
}

//MARK: - Helper Functions
extension Pass {
    
    func formattedRideAccessForPass() -> String {
        return "\u{2022} " + rideAccess.map{ $0.rawValue }.joined(separator: "\n\u{2022} ")
    }
    
    func formattedDiscountsForPass() -> String {
        if let discounts = self.discounts {
            var discountsString: String = ""
            for discount in discounts {
                switch discount {
                case .food:
                    discountsString += "\u{2022} Food discount: \(discount.formattedValue())\n"
                case .merchandise:
                    discountsString += "\u{2022} Merchandise discount: \(discount.formattedValue())\n"
                }
            }
            return discountsString
        } else {
            return ""
        }
    }
    
}
