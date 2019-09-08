//
//  VendorCompany.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 29-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum VendorCompany: String, CaseIterable {
    case acme = "Acme"
    case orkin = "Orkin"
    case fedex = "Fedex"
    case nwElectrical = "NW Electrical"
    
    static func allCasesAsStrings() -> [String] {
        return self.allCases.map {$0.rawValue}
    }
    
    static func vendorForRow(_ row: Int) -> VendorCompany? {
        switch row {
        case 0: return .acme
        case 1: return .orkin
        case 2: return .fedex
        case 3: return .nwElectrical
        default: return nil
        }
    }
}
