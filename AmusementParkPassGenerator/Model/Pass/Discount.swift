//
//  DiscountOn.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 07-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

enum Discount {
    case food(Double)
    case merchandise(Double)
    
    func value () -> Double {
        switch self {
        case .food(let value):  return value
        case .merchandise(let value): return value
        }
    }
}
