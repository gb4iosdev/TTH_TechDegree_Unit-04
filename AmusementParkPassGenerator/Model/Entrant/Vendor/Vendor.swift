//
//  Vendor.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 29-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class Vendor: Entrant {
    
    var entrantInformation: EntrantInformation?
    let pass: Pass
    let visitDate: Date
    
    init(entrantInformation information: EntrantInformation) throws {
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation(detail: "Missing Name information for vendor")
        }
        guard let vendorCompany = information.company, let accessAreas = VendorCompanyDataSource.accessAreas[vendorCompany]  else {
            throw InformationError.invalidVendorCompany(detail: "Vendor Company is not registered")
        }
        
        self.entrantInformation = information
        self.pass = Pass(of: .vendorPass, to: accessAreas, rides: [.noRideAccess])
        self.visitDate = Date()
    }
}
