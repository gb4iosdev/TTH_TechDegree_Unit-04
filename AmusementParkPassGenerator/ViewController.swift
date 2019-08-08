//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 28-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Test Data Structure Creation
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let birthDateAsString1 = "2005-05-22"
        let birthDateAsString2 = "2016-05-22"
        let birthDateAsString3 = "2007-08-07"
        guard let birthDate1 = format.date(from: birthDateAsString1) else { return }
        guard let birthDate2 = format.date(from: birthDateAsString2) else { return }
        guard let birthDate3 = format.date(from: birthDateAsString3) else { return }

        //Date of birth for child
        let information1 = EntrantInformation(firstName: nil, lastName: nil, streetAddress: nil, city: nil, state: nil, zipCode: nil, socialSecurityNumber: nil, dateOfBirth: birthDate1)
        //Date of birth too old for child
        let information2 = EntrantInformation(firstName: nil, lastName: nil, streetAddress: nil, city: nil, state: nil, zipCode: nil, socialSecurityNumber: nil, dateOfBirth: birthDate2)
        //Missing name information
        let information3 = EntrantInformation(firstName: "Gavin", lastName: nil, streetAddress: "35 Test Street", city: "Barrie", state: "Ontario", zipCode: "K5T 7G5", socialSecurityNumber: 123546, dateOfBirth: birthDate2)
        //All base information present
        let information4 = EntrantInformation(firstName: "Gavin", lastName: "Senter", streetAddress: "35 Test Street", city: "Barrie", state: "Ontario", zipCode: "K5T 7G5", socialSecurityNumber: 123546, dateOfBirth: birthDate2)
        //Missing address information
        let information5 = EntrantInformation(firstName: "Gavin", lastName: "Jones", streetAddress: "35 Test Street", city: nil, state: "Ontario", zipCode: "K5T 7G5", socialSecurityNumber: 123546, dateOfBirth: birthDate2)
        //Missing SSN information
        let information6 = EntrantInformation(firstName: "Gavin", lastName: "Jones", streetAddress: "35 Test Street", city: "Barrie", state: "Ontario", zipCode: "K5T 7G5", socialSecurityNumber: nil, dateOfBirth: birthDate2)
        //Test Birthday Message
        let information7 = EntrantInformation(firstName: "Gavin", lastName: "Jones", streetAddress: "35 Test Street", city: "Barrie", state: "Ontario", zipCode: "K5T 7G5", socialSecurityNumber: 458, dateOfBirth: birthDate3)

//        //Create Classic Guest
//        var classicGuest1 = ClassicGuest()
//        print("**** Classic Guest Start ****\n")
//        dump(classicGuest1)
//        classicGuest1.processSwipeAt(.amusement)        // Should allow access
//        classicGuest1.processSwipeAt(.kitchen)          // Should deny access
//        print("**** Classic Guest End ****\n\n")
        
        
//        //Create VIP Guest
//        var vipGuest1 = VIPGuest()
//        print("**** VIP Guest Start ****\n")
//        dump(vipGuest1)
//        vipGuest1.processSwipeAt(.maintenance)          // Should deny access
//        print("**** VIP Guest End ****\n\n")
        
        
//        //create the Free Child Guest (should fail - entrant to old):
//        print("**** Free Child Guest Fail Start ****\n")
//        do {
//            let child1 = try FreeChildGuest(entrantInformation: information1)
//            dump(child1)
//        } catch let error {
//            printError(error: error)
//        }
//        print("**** Free Child Guest Fail End ****\n\n")
        
//        //create the Free Child Guest (should succeed):
//        print("**** Free Child Guest Succeed Start ****\n")
//        do {
//            var child1 = try FreeChildGuest(entrantInformation: information2)
//            dump(child1)
//            child1.processSwipeAt(.office)              // Should deny access
//            child1.processSwipeAt(.rideControl)         // Should deny access
//        } catch let error {
//            printError(error: error)
//        }
//        print("**** Free Child Guest Succeed End ****\n\n")
        
        
//        //Create the manager - fail on missing name information
//        print("**** Manager Fail Start ****\n")
//        do {
//            let manager1 = try Manager(entrantInformation: information3, managementTier: ManagementTier.shiftManager)
//            dump(manager1)
//        } catch let error {
//            printError(error: error)
//        }
//        print("**** Manager Fail End ****\n\n")
        
//        //Create the manager - (should succeed)
//        print("**** Manager Success Start ****\n")
//        do {
//            var manager1 = try Manager(entrantInformation: information4, managementTier: ManagementTier.generalManager)
//            dump(manager1)
//            manager1.processSwipeAt(.kitchen)                   // Should allow access
//            manager1.processSwipeAt(.maintenance)               // Should allow access
//            manager1.processSwipeAt(.office)                    // Should allow access
//            manager1.processSwipeAt(.office)                    // Should deny access based on time since last swipe
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {   // Should deny access based on time since last swipe
//                manager1.processSwipeAt(.office)
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {   // Should allow access based on time since last swipe
//                manager1.processSwipeAt(.office)
//            }
//        } catch let error {
//            printError(error: error)
//        }
//        print("**** Manager Success End ****\n\n")
        

//        //Create the hourly employee - fail on missing address information
//        print("**** Hourly Employee Fail Start ****\n")
//        do {
//            let hourlyEmployee1 = try HourlyEmployee (ofType: .foodServices, entrantInformation: information5)
//            dump(hourlyEmployee1)
//        } catch let error {
//            printError(error: error)
//        }
//        print("**** Hourly Employee Fail End ****\n\n")
        
//        //Create the hourly employee - fail on missing SSN information
//        print("**** Hourly Employee Fail Start ****\n")
//        do {
//            let hourlyEmployee1 = try HourlyEmployee (ofType: .maintenance, entrantInformation: information6)
//            dump(hourlyEmployee1)
//        } catch let error {
//            printError(error: error)
//        }
//        print("**** Hourly Employee Fail End ****\n\n")
        
//        //Create the hourly employee - (should succeed)
//        print("**** Hourly Employee Success Start ****\n")
//        do {
//            var hourlyEmployee1 = try HourlyEmployee (ofType: .rideServices, entrantInformation: information4)
//            dump(hourlyEmployee1)
//            hourlyEmployee1.processSwipeAt(.kitchen)            // Should deny access based on subtype
//            hourlyEmployee1.processSwipeAt(.rideControl)        // Should allow access
//        } catch let error {
//            printError(error: error)
//        }
//        print("**** Hourly Employee Success End ****\n\n")

//        //Create the hourly employee - (should succeed with Happy Birthday message)
//        print("**** Hourly Employee2 Happy Bday Start ****\n")
//        do {
//            var hourlyEmployee2 = try HourlyEmployee (ofType: .rideServices, entrantInformation: information7)
//            dump(hourlyEmployee2)
//            hourlyEmployee2.processSwipeAt(.rideControl)        // Should allow access & display happy birthday message
//        } catch let error {
//            printError(error: error)
//        }
//        print("**** Hourly Employee2 Happy Bday End ****\n\n")

    }
}

extension ViewController {
    
    // MARK: - Helper methods
    
    func printError(error: Error) {
        if let thisError = error as? InformationError {
            switch thisError {
            case .incorrectAge(let errDetail):
                print(errDetail)
            case .missingNameInformation(let errDetail):
                print(errDetail)
            case .missingAddressInformation(let errDetail):
                print(errDetail)
            case .missingSocialSecurityNumber(let errDetail):
                print(errDetail)
            }
        } else {
            print("Unknown error")
        }
    }
}


