//
//  EntrantType.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Entrant types to display on top button row, and their tags
enum EntrantType: Int {
    case guest = 1
    case employee = 2
    case manager = 3
    case contractor = 4
    case vendor = 5
    
    //Returns the associated entrant sub-types to allow buttons to be created on the second row of the main View Controller.
    func subTypes() -> [EntrantSubType] {
        switch self {
        case .guest: return [
            .childGuest,
            .classicGuest,
            .seniorGuest,
            .vipGuest,
            .seasonPassGuest]
        case .employee: return [
            .hourlyEmployee_foodServices,
            .hourlyEmployee_rideServices,
            .hourlyEmployee_maintenance]
        case .manager: return [
            .manager_shift,
            .manager_senior,
            .manager_general]
        case .contractor: return [
            .contractor]
        case .vendor: return [
            .vendor]
        }
    }
}
