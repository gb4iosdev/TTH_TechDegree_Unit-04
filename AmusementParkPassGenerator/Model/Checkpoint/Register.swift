//
//  Register.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 21-08-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import Foundation

class Register: Checkpoint {
    func swipe(_ pass: Pass) {
        checkPassForBirthday(pass)
        guard let discounts = pass.discounts else {
            print("Entrant is not eligible for any discounts")
            return
        }
        print("Entrant is eligible for the following discounts\n")
        for discount in discounts {
            print("Discount on \(discount) is: \(discount.value() * 100)%")
        }
    }
}
