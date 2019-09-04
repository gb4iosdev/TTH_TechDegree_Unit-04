//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 28-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let testManager = TestManager()     //Manage Test Cases for Project 4
    let inputValidator = InputValidation()  //Manage Text Field validation
    
    @IBOutlet var entrantTypeButtons: [UIButton]!
    @IBOutlet weak var entrantSubTypeStackView: UIStackView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var ssnTextField: UITextField!
    
    
    @IBOutlet weak var companyPicker: UIPickerView!
    @IBOutlet weak var projectPicker: UIPickerView!
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePickers()
        configureTextFields()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK:- Picker views
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func configurePickers() {
        //Set date picker mode and default date
        datePicker.datePickerMode = UIDatePicker.Mode.date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        if let defaultDate = dateFormatter.date(from: "01 Jan 2000") {
            datePicker.date = defaultDate
        }
        
//        let selectedDate = dateFormatter.string(from: datePicker.date)
//        print(selectedDate)
        
        //Set company and project pickers delegates and data sources to this View Controller
        companyPicker.delegate = self
        companyPicker.dataSource = self
        projectPicker.delegate = self
        projectPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView === projectPicker {
            return ProjectDataSource.projects.count
        }
        
        if pickerView === companyPicker {
            return VendorCompany.allCases.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView === projectPicker {
            return String(ProjectDataSource.projects[row])
        }
        
        if pickerView === companyPicker {
            return VendorCompany.allCasesAsStrings()[row]
        }
        
        return nil
    }
}

//MARK:- Text Fields
extension ViewController: UITextFieldDelegate {
    
    func configureTextFields() {
        ssnTextField.delegate = self
        zipCodeTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let textFieldLength = textField.text?.count ?? 0
        let fieldCharacterSet = CharacterSet(charactersIn: string)
        
        switch textField {
        case ssnTextField:  //Restrict to digits and 11 characters max (dashes to be stripped later)
            return inputValidator.allowedSSNCharacters.isSuperset(of: fieldCharacterSet) && textFieldLength < inputValidator.ssnMaxLength
        case zipCodeTextField:  //Restrict to digits and 5 characters max
            return inputValidator.allowedZipCodeCharacters.isSuperset(of: fieldCharacterSet) && textFieldLength < inputValidator.zipCodeMaxLength
        default:
            return true
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("Keyboard is gonna show")
    }
}
