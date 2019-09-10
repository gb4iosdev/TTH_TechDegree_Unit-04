//
//  PassTesterViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 09-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class PassTesterViewController: UIViewController {
    
    var entrant: Entrant?
    
    
    @IBOutlet weak var passNameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var passDetailLabel: UILabel!
    
    
    @IBOutlet var testButtons: [UIButton]!
    
    @IBOutlet weak var testResultsLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //displayEntitlementsOnPass() 
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func createNewPassButtonPressed(_ sender: UIButton) {
    }
    

}
