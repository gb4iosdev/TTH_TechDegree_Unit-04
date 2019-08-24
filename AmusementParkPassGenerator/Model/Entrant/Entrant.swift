//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

protocol Entrant {
    var pass: Pass { get }
    var entrantInformation: EntrantInformation? { get }
}
