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
}
