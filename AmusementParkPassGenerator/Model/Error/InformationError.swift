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
    
    func title() -> String {
        switch self {
        case .incorrectAge: return "Incorrect Age"
        case .missingNameInformation: return "Missing Name Information"
        case .missingAddressInformation: return "Missing Address Information"
        case .missingSocialSecurityNumber: return "Missing SSN Information"
        case .invalidProject: return "Project Not Found"
        case .invalidVendorCompany: return "Vendor Company Not Found"
        }
    }
    
    func message() -> String {
        switch self {
        case .incorrectAge(let errorDetail): return errorDetail
        case .missingNameInformation(let errorDetail): return errorDetail
        case .missingAddressInformation(let errorDetail): return errorDetail
        case .missingSocialSecurityNumber(let errorDetail): return errorDetail
        case .invalidProject(let errorDetail): return errorDetail
        case .invalidVendorCompany(let errorDetail): return errorDetail
        }
    }
}
