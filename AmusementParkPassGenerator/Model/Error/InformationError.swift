//
//  InformationError.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum InformationError: Error {
    case incorrectAge(detail: String)
    case missingNameInformation(detail: String)
    case missingAddressInformation(detail: String)
    case missingSocialSecurityNumber(detail: String)
    case invalidProject(detail: String)
    case invalidVendorCompany(detail: String)
}
