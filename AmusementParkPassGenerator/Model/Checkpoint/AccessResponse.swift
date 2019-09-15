//
//  AccessResponse.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 15-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

//Message to display in the test panel, boolean to determine pass/fail & set test panel colour
struct AccessResponse {
    var accessResponseMessage: String
    let accessIsGranted: Bool
}
