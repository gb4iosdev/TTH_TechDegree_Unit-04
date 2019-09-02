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
    
    @IBOutlet var entrantTypeButtons: [UIButton]!
    @IBOutlet weak var entrantSubTypeStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.entrantTypeButtons[0].isHidden = true
//        }
        
        //testManager.runTests()
        
    }
    
    @IBAction func entrantTypeSelected(_ sender: UIButton) {
        //Make the selected Entrant Type button text bold.  Unbold all others
        for button in entrantTypeButtons {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24.0)
        }
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        
        //Remove all subType buttons
        for view in entrantSubTypeStackView.arrangedSubviews {
            entrantSubTypeStackView.removeArrangedSubview(view)
        }
        
        //Set all information fields to not user enabled
        
        displayEntrantSubtypes(sender.tag)
        
        //Disable Generate Pass button
    }
    
    func displayEntrantSubtypes(_ entrantTypeTag: Int) {
        
        guard let subTypeButtonTitles = entrantSubTypeButtonTitles(for: entrantTypeTag) else { return }
        
        for (buttonTitle, entrantSubType) in subTypeButtonTitles {
            print("gog in hereree & button title is: \(buttonTitle)")
            let button = EntrantSubTypeButton()
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.setTitle(buttonTitle, for: .normal)
            button.classToGenerate = entrantSubType
            button.backgroundColor = .blue
            button.addTarget(self, action: #selector(ViewController.entrantSubTypeSelected(button:)), for: .touchUpInside)
            entrantSubTypeStackView.addArrangedSubview(button)
        }
    }
    
    func entrantSubTypeButtonTitles(for tag: Int) -> [String : EntrantSubType]? {
        
        switch tag {
        case 1: return [
            "Child" : .childGuest,
            "Classic" : .classicGuest,
            "Senior" : .seniorGuest,
            "VIP" : .vipGuest,
            "Senior Pass" : .seasonPassGuest
            ]
        case 2: return [
            "Food Services" : .hourlyEmployee(.foodServices),
            "Ride Services" : .hourlyEmployee(.rideServices),
            "Maintenance" : .hourlyEmployee(.maintenance)
            ]
        case 3: return [
            "Shift" : .manager(.shiftManager),
            "Senior" : .manager(.seniorManager),
            "General" : .manager(.generalManager)
            ]
        case 4: return [
            "Contractor" : .contractor
            ]
        case 5: return [
            "Vendor" : .vendor
            ]
        default: return nil
        }
    }
    
    @objc func entrantSubTypeSelected(button: EntrantSubTypeButton!) {
        print("button selected is: \(button.currentTitle ?? "No title")")
        print("class to generate is: \(String(describing: button.classToGenerate))")
        for view in entrantSubTypeStackView.arrangedSubviews {
            if let button = view as? EntrantSubTypeButton {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
            }
        }
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        
    }
}


