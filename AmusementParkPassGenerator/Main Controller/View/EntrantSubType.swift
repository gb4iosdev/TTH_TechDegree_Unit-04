//
//  EntrantSubType.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 01-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Entrant sub types and their button titles
enum EntrantSubType: String {
    case childGuest = "Child"
    case classicGuest = "Classic"
    case seniorGuest = "Senior"
    case vipGuest = "VIP"
    case seasonPassGuest = "Season Pass"
    case hourlyEmployee_foodServices = "Food Services"
    case hourlyEmployee_rideServices = "Ride Services"
    case hourlyEmployee_maintenance = "Maintenance"
    case manager_shift = "Shift"
    case manager_senior = "Senior "
    case manager_general = "General"
    case contractor = "Contractor"
    case vendor = "Vendor"
}
