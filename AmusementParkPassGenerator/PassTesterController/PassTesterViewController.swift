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
    lazy var office = Checkpoint(ofType: .areaAccess, inArea: .office)
    
    
    @IBOutlet weak var passNameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var passDetailLabel: UILabel!
    
    
    @IBOutlet var testButtons: [UIButton]!
    
    @IBOutlet weak var testResultsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("in new VC and entrant dump is: \(String(describing: dump(entrant)))")
        if let currentEntrantInformation = entrant?.entrantInformation {
            passNameLabel.text = currentEntrantInformation.formattedNameForTextField
            
        }
        
        if let entrant = self.entrant {
            passTypeLabel.text = entrant.pass.type.rawValue
            passDetailLabel.text = entrant.pass.formattedRideAccessForPass() + "\n" + entrant.pass.formattedDiscountsForPass()
        }
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
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        
        //guard let testButtonTag = sender.tag else { return }
        
        guard let buttonPressed = TestButton(rawValue: sender.tag) else { return }
        //print("sender.tag is \(sender.tag)")
        switch buttonPressed {
        case .office:
            print("office")
        case .kitchen:
            print("office")
        case .rideControl:
            print("office")
        case .amusement:
            print("office")
        case .rides:
            print("office")
        case .foodDiscount:
            print("office")
        case .merchandiseDiscount:
            print("office")
        case .maintenance:
            print("office")

        }
        
    }
    
    
    @IBAction func createNewPassButtonPressed(_ sender: UIButton) {
        
        
    }
    

}
