//
//  PassTesterViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 09-09-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class PassTesterViewController: UIViewController {
    
    //General variable declarations
    var entrant: Entrant?
    var soundPlayer = SoundPlayer()
    
    //MARK: Outlet Variables
    @IBOutlet weak var passNameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var passDetailLabel: UILabel!
    
    @IBOutlet var testButtons: [UIButton]!
    
    @IBOutlet weak var testResultsLabel: UILabel!
    
    //Setup all checkpoints
    let office = Checkpoint(ofType: .areaAccess, in: .office)
    let kitchen = Checkpoint(ofType: .areaAccess, in: .kitchen)
    let rideControl = Checkpoint(ofType: .areaAccess, in: .rideControl)
    let amusement = Checkpoint(ofType: .areaAccess, in: .amusement)
    let maintenance = Checkpoint(ofType: .areaAccess, in: .maintenance)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Prepare sound player
        soundPlayer.loadAccessSounds()
        
        //Populate the Pass if entrant information exists:
        //Entrant Name:
        if let currentEntrantInformation = entrant?.entrantInformation {
            passNameLabel.text = currentEntrantInformation.formattedFullName
            
        }
        //Pass Type and benefits:
        if let entrant = self.entrant {
            passTypeLabel.text = entrant.pass.type.rawValue
            passDetailLabel.text = entrant.pass.formattedRideAccessForPass() + "\n" + entrant.pass.formattedDiscountsForPass()
        }
    }
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        
        //Check that button pressed is from the group expected - see TestButton enumeration
        guard let buttonPressed = TestButton(rawValue: sender.tag) else { return }
        
        //Ensure the entrant variable is set
        guard let entrant = self.entrant else { return }
        
        var accessIsGranted: Bool
        
        //Test the entrant's pass swipe at the checkpoint per the button pressed, or the pass directly for discount and ride access information.
        switch buttonPressed {
        case .office:
            let swipeResult = entrant.swipe(at: office)
            testResultsLabel.text = swipeResult.accessResponseMessage
            accessIsGranted = swipeResult.accessIsGranted
        case .kitchen:
            let swipeResult = entrant.swipe(at: kitchen)
            testResultsLabel.text = swipeResult.accessResponseMessage
            accessIsGranted = swipeResult.accessIsGranted
        case .rideControl:
            let swipeResult = entrant.swipe(at: rideControl)
            testResultsLabel.text = swipeResult.accessResponseMessage
            accessIsGranted = swipeResult.accessIsGranted
        case .amusement:
            let swipeResult = entrant.swipe(at: amusement)
            testResultsLabel.text = swipeResult.accessResponseMessage
            accessIsGranted = swipeResult.accessIsGranted
        case .rides:
            accessIsGranted = entrant.pass.hasRideAccess
            testResultsLabel.text = entrant.pass.formattedRideAccessForPass()
        case .foodDiscount:
            accessIsGranted = entrant.pass.hasDiscount(for: .food)
            testResultsLabel.text = entrant.pass.formattedDiscount(for: .food)
        case .merchandiseDiscount:
            accessIsGranted = entrant.pass.hasDiscount(for: .merchandise)
            testResultsLabel.text = entrant.pass.formattedDiscount(for: .merchandise)
        case .maintenance:
            let swipeResult = entrant.swipe(at: maintenance)
            testResultsLabel.text = swipeResult.accessResponseMessage
            accessIsGranted = swipeResult.accessIsGranted
        }
        
        //Set Test Label's appropriate background colour and play appropriate sound
        if accessIsGranted {
            testResultsLabel.backgroundColor = .green
            soundPlayer.playAccessGrantedSound()
        } else {
            testResultsLabel.backgroundColor = .red
            soundPlayer.playAccessDeniedSound()
        }
    }
    
    
    @IBAction func createNewPassButtonPressed(_ sender: UIButton) {
        //Return to main view controller
        dismiss(animated: true, completion: nil)
    }
}
