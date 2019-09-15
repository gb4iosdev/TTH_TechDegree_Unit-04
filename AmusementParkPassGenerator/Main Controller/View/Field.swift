//
//  Field.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//To track information fields rather than using just the tag.  Tag is enum raw value.
enum Field: Int {
    case dateOfBirth = 10
    case ssn
    case firstName
    case lastName
    case company
    case project
    case streetAddress
    case city
    case state
    case zipCode
}
