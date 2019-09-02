//
//  EntrantSubType.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 01-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum EntrantSubType {
    case childGuest
    case classicGuest
    case seniorGuest
    case vipGuest
    case seasonPassGuest
    case hourlyEmployee(HourlyEmployeeType)
    case manager(ManagementTier)
    case contractor
    case vendor
}
