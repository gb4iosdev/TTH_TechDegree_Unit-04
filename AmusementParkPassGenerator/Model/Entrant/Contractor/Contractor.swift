//
//  Contractor.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 29-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class Contractor: Entrant {
    
    var entrantInformation: EntrantInformation?
    let pass: Pass
    
    init(entrantInformation information: EntrantInformation) throws {
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation(detail: "Missing Name information for contractor")
        }
        guard information.streetAddress != nil, information.city != nil, information.state != nil, information.zipCode != nil else {
            throw InformationError.missingAddressInformation(detail: "Missing Address information for contractor")
        }
        guard information.socialSecurityNumber != nil else {
            throw InformationError.missingSocialSecurityNumber(detail: "Missing Social Security Number for contractor")
        }
        guard let project = information.projectNumber, let accessAreas = ProjectDataSource.accessAreas[project]  else {
            throw InformationError.invalidProject(detail: "Project number is not registered")
        }
        
        self.entrantInformation = information
        self.pass = Pass(of: .contractorPass, to: accessAreas, rides: [.noRideAccess])
    }
}
