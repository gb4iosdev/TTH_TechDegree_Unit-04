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
        
        ///Access Area Setup
        
        let amusementArea = AccessArea(.amusement)
        let kitchenArea = AccessArea(.kitchen)
        let rideControlArea = AccessArea(.rideControl)
        let maintenanceArea = AccessArea(.maintenance)
        let officeArea = AccessArea(.office)
        
        ///Test Data Structure Creation
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let birthDateAsString1 = "2005-05-22"
        let birthDateAsString2 = "2016-05-22"
        guard let birthDate1 = format.date(from: birthDateAsString1) else { return }
        guard let birthDate2 = format.date(from: birthDateAsString2) else { return }
        
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
        
        func printError(error: Error) {
            if let thisError = error as? InformationError {
                switch thisError {
                case .incorrectAge:
                    print("Entrant is too old for Child Pass")
                case .missingNameInformation:
                    print("Entrant is missing name information")
                case .missingAddressInformation:
                    print("Entrant is missing address information")
                case .missingSocialSecurityNumber:
                    print("Entrant is missing Social Security Number")
                }
            } else {
                print("Unknown error")
            }
        }
        
        func delaySwipe(by seconds: Int, for entrant: Entrant) {
            // Converts a delay in seconds to nanoseconds as signed 64 bit integer
            let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
            // Calculates a time value to execute the method given current time and delay
            let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
            
            // Executes the nextRound method at the dispatch time on the main queue
            DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                officeArea.processSwipeFrom(entrant)             }
        }
        
        //Create Classic Guest
        let classicGuest1 = ClassicGuest()
        print("**** Classic Guest Start ****\n")
        dump(classicGuest1)
        amusementArea.processSwipeFrom(classicGuest1)       // Should allow access
        kitchenArea.processSwipeFrom(classicGuest1)         // Should deny access
        print("**** Classic Guest End ****\n\n")
        
        //Create VIP Guest
        let vipGuest1 = VIPGuest()
        print("**** VIP Guest Start ****\n")
        dump(vipGuest1)
        maintenanceArea.processSwipeFrom(vipGuest1)         // Should deny access
        print("**** VIP Guest End ****\n\n")
        
        //create the Free Child Guest (should fail - entrant to old):
        print("**** Free Child Guest Fail Start ****\n")
        do {
            let child1 = try FreeChildGuest(entrantInformation: information1)
            dump(child1)
        } catch let error {
            printError(error: error)
        }
        print("**** Free Child Guest Fail End ****\n\n")
        
        
        //create the Free Child Guest (should succeed):
        print("**** Free Child Guest Succeed Start ****\n")
        do {
            let child1 = try FreeChildGuest(entrantInformation: information2)
            dump(child1)
            officeArea.processSwipeFrom(child1)                 // Should deny access
            rideControlArea.processSwipeFrom(child1)            // Should deny access
        } catch let error {
            printError(error: error)
        }
        print("**** Free Child Guest Succeed End ****\n\n")
        
        //Create the manager - fail on missing name information
        print("**** Manager Fail Start ****\n")
        do {
            let manager1 = try Manager(entrantInformation: information3, managementTier: ManagementTier.shiftManager)
            dump(manager1)
        } catch let error {
            printError(error: error)
        }
        print("**** Manager Fail End ****\n\n")
        
        //Create the manager - (should succeed)
        print("**** Manager Success Start ****\n")
        do {
            let manager1 = try Manager(entrantInformation: information4, managementTier: ManagementTier.generalManager)
            dump(manager1)
            kitchenArea.processSwipeFrom(manager1)              // Should allow access
            maintenanceArea.processSwipeFrom(manager1)          // Should allow access
            officeArea.processSwipeFrom(manager1)               // Should allow access
            officeArea.processSwipeFrom(manager1)               // Should deny access based on time since last swipe
            delaySwipe(by: 4, for: manager1)            // Should deny access based on time since last swipe
            delaySwipe(by: 6, for: manager1)            // Should allow access
        } catch let error {
            printError(error: error)
        }
        print("**** Manager Success End ****\n\n")
        
        //Create the hourly employee - fail on missing address information
        print("**** Hourly Employee Fail Start ****\n")
        do {
            let hourlyEmployee1 = try HourlyEmployee (ofType: .foodServices, entrantInformation: information5)
            dump(hourlyEmployee1)
        } catch let error {
            printError(error: error)
        }
        print("**** Hourly Employee Fail End ****\n\n")
    
        //Create the hourly employee - fail on missing SSN information
        print("**** Hourly Employee Fail Start ****\n")
        do {
        let hourlyEmployee1 = try HourlyEmployee (ofType: .maintenance, entrantInformation: information6)
        dump(hourlyEmployee1)
        } catch let error {
            printError(error: error)
        }
        print("**** Hourly Employee Fail End ****\n\n")


        //Create the hourly employee - (should succeed)
        print("**** Hourly Employee Success Start ****\n")
        do {
            let hourlyEmployee1 = try HourlyEmployee (ofType: .rideServices, entrantInformation: information4)
            dump(hourlyEmployee1)
            kitchenArea.processSwipeFrom(hourlyEmployee1)       // Should deny access based on subtype
            rideControlArea.processSwipeFrom(hourlyEmployee1)   // Should allow access
        } catch let error {
            printError(error: error)
        }
        print("**** Hourly Employee Success End ****\n\n")
    }
}

protocol Entrant {
    var pass: AmusementParkPass { get }
    var entrantInformation: EntrantInformation? { get }
    var lastSwipeTimeStamp: [Area : Date]? { get set }
}

class ClassicGuest: Entrant {
    var pass: AmusementParkPass
    var entrantInformation: EntrantInformation? = nil
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    init() {
        self.pass = AmusementParkPass(
            areaAccess: [Area.amusement],
            discounts: nil,
            rideAccess: [.allRides]
        )
    }
}

class VIPGuest: Entrant {
    
    let pass: AmusementParkPass
    var entrantInformation: EntrantInformation? = nil
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    init() {
        self.pass = AmusementParkPass(
            areaAccess: [Area.amusement],
            discounts: [.food : 0.1, .merchandise : 0.2],
            rideAccess: [.allRides, .skipLines]
        )
    }
}

class FreeChildGuest: Entrant {
    
    let pass: AmusementParkPass
    let entrantInformation: EntrantInformation?
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    let childAgeThreshold = 5
    let yearDivisor: Double = 3600*24*365   //Number of seconds in a year
    
    init(entrantInformation information: EntrantInformation) throws {
        
        //Check entrant is less than or equal to 5 years old
        let currentDate = Date()
        let durationInSeconds = currentDate.timeIntervalSince(information.dateOfBirth)
        let ageOfEntrant = durationInSeconds / yearDivisor
        
        print("Age of entrant is: \(ageOfEntrant)")
        
        guard ageOfEntrant <= 5.0 else {
            throw InformationError.incorrectAge
        }
        
        self.entrantInformation = information
        
        self.pass = AmusementParkPass(
            areaAccess: [Area.amusement],
            discounts: nil,
            rideAccess: [.allRides]
        )
    }
}

enum ManagementTier {
    case shiftManager
    case generalManager
    case seniorManager
}

class Manager: Entrant {
    
    var entrantInformation: EntrantInformation?
    let pass: AmusementParkPass
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    var managementTier: ManagementTier
    
    init(entrantInformation information: EntrantInformation, managementTier tier: ManagementTier) throws {
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation
        }
        guard information.streetAddress != nil, information.city != nil, information.state != nil, information.zipCode != nil else {
            throw InformationError.missingAddressInformation
        }
        guard information.socialSecurityNumber != nil else {
            throw InformationError.missingSocialSecurityNumber
        }
        
        self.entrantInformation = information
        self.managementTier = tier
        
        self.pass = AmusementParkPass(
            areaAccess: Set(Area.allCases),
            discounts: [.food : 0.25, .merchandise : 0.25],
            rideAccess: [.allRides]
        )
    }
}

class HourlyEmployee: Entrant {
    
    var entrantInformation: EntrantInformation?
    let pass: AmusementParkPass
    var lastSwipeTimeStamp: [Area : Date]? = nil
    
    init(ofType type: HourlyEmployeeType, entrantInformation information: EntrantInformation) throws {
        guard information.firstName != nil, information.lastName != nil else {
            throw InformationError.missingNameInformation
        }
        guard information.streetAddress != nil, information.city != nil, information.state != nil, information.zipCode != nil else {
            throw InformationError.missingAddressInformation
        }
        guard information.socialSecurityNumber != nil else {
            throw InformationError.missingSocialSecurityNumber
        }
        
        self.entrantInformation = information
        
        var accessAreas: Set<Area> {
            switch type {
            case .foodServices: return [.amusement, .kitchen]
            case .rideServices: return [.amusement, .rideControl]
            case .maintenance: return [.amusement, .kitchen, .rideControl, .maintenance]
            }
        }
        
        self.pass = AmusementParkPass(
            areaAccess: accessAreas,
            discounts: [.food : 0.15, .merchandise : 0.25],
            rideAccess: [.allRides]
        )
    }
}

enum HourlyEmployeeType {
    case foodServices
    case rideServices
    case maintenance
}


enum InformationError: Error {
    case incorrectAge
    case missingNameInformation              //put associated info here to pass object back???
    case missingAddressInformation
    case missingSocialSecurityNumber
}


struct EntrantInformation {
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let socialSecurityNumber: Int?
    let dateOfBirth: Date
}

protocol Pass {
    var areaAccess: Set<Area> { get }
    var discounts: [DiscountOn : Double]? { get }
    var rideAccess: Set<RideAccessType> { get }
}

struct AmusementParkPass: Pass {
    var areaAccess: Set<Area>
    var discounts: [DiscountOn : Double]?
    var rideAccess: Set<RideAccessType>
    
    func canAccessArea(_ area: Area) -> Bool {
        return self.areaAccess.contains(area)
    }
    
    func canAccessRide(_ ride: RideAccessType) -> Bool {
        return self.rideAccess.contains(ride)
    }
    
    func printDiscounts() {
        if let discounts = self.discounts {
            for (key, value) in discounts {
                print("Discount on \(key) is: \(value * 100)%")
            }
        }
    }
}

enum Area: String, CaseIterable {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum DiscountOn {
    case food
    case merchandise
}

enum RideAccessType {
    case allRides
    case skipLines
    //case //****Check entrant access rules from next project****//
}

class AccessArea {
    
    var areaType: Area
    var repeatedSwipeTimeLimit: Double = 5.0
    
    init(_ area: Area) {
        self.areaType = area
    }
    
    func processSwipeFrom(_ entrant: Entrant)  {
        
        
        //Check if swiped too soon:
        if let lastSwipeTime = entrant.lastSwipeTimeStamp?[self.areaType], Date().timeIntervalSince(lastSwipeTime) < repeatedSwipeTimeLimit {
            print("Can’t access same area within \(repeatedSwipeTimeLimit) seconds")
            return
        }
        
        //Record the swipe:
        //entrant.lastSwipeTimeStamp?[self.areaType] = Date()
        
        if entrant.pass.canAccessArea(self.areaType) {
            print("***SWIPE COMMENCED***")
            print("Entrant has access to area \(self.areaType.rawValue)")
            print("Ride access type/s: \(entrant.pass.rideAccess)")
            print("Discounts are: \(entrant.pass.printDiscounts())")
        } else {
            print("Entrant does not have access")
        }
        
        //Celebrate birthday:
        if let entrantBirthdate = entrant.entrantInformation?.dateOfBirth {
            let format = DateFormatter()
            format.dateFormat = "MM-dd"
            let formattedToday = format.string(from: Date())
            let formattedEntrantBirthDate = format.string(from: entrantBirthdate)
            
            if formattedToday == formattedEntrantBirthDate {
                print("Wish the entrant a happy birthday!!")
            }
        }
    }
}
