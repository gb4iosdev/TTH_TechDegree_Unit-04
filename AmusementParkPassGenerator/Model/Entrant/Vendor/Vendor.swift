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
    let vendorCompany: VendorCompany
    let visitDate: Date
    
    init(entrantInformation information: EntrantInformation, from company: VendorCompany) throws {
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation(detail: "Missing Name information for vendor")
        }
        guard let accessAreas = VendorCompanyDataSource.accessAreas[company]  else {
            throw InformationError.invalidVendorCompany(detail: "Vendor Company is not registered")
        }
        
        self.vendorCompany = company
        self.entrantInformation = information
        self.pass = Pass(to: accessAreas, rides: [.noRideAccess])
        self.visitDate = Date()
    }
}
