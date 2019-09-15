//
//  EntrantInformation.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Captures optional and required data for entrants
struct EntrantInformation {
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let socialSecurityNumber: Int?
    let projectNumber: Int?
    let company: VendorCompany?
    let dateOfBirth: Date
    
    //Return full name for the Pass on PassTesterViewController
    var formattedFullName: String? {
        if let first = firstName, let last = lastName {
            return first + " " + last
        } else {
            return nil
        }
    }
}
