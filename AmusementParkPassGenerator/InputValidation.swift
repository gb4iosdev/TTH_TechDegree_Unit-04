//
//  InputValidation.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 03-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class InputValidation {
    
    //SSN Field Validation Parameters
    let allowedSSNCharacters = CharacterSet(charactersIn: "-123456789")
    let ssnMaxLength = 11   //Includes dashes if used
    
    //Zip Code Validation Parameters
    let allowedZipCodeCharacters = CharacterSet(charactersIn: "123456789")
    let zipCodeMaxLength = 5
}
