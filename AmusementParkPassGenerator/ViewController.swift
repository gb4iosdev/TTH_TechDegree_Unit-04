//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 28-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let testManager = TestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testManager.runTests()
        
    }
}


