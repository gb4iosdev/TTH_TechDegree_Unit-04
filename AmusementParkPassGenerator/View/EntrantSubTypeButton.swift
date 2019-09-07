//
//  EntrantSubTypeButton.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 01-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class EntrantSubTypeButton: UIButton {

    var entrantSubType: EntrantSubType
    
    init(entrantSubType: EntrantSubType) {
        self.entrantSubType = entrantSubType
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
