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
    
    // MARK: - Outlets
    //Entrant Selection Buttons
    @IBOutlet var entrantTypeButtons: [UIButton]!
    @IBOutlet weak var entrantSubTypeStackView: UIStackView!
    
    //Row 1 Fields
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerGroup: UIStackView!
    
    @IBOutlet weak var ssnTextField: UITextField!
    @IBOutlet weak var ssnGroup: UIStackView!
    
    //Row 2 Fields
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameGroup: UIStackView!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNameGroup: UIStackView!
    
    //Row 3 Fields
    @IBOutlet weak var companyPicker: UIPickerView!
    @IBOutlet weak var companyPickerGroup: UIStackView!
    @IBOutlet weak var projectPicker: UIPickerView!
    @IBOutlet weak var projectPickerGroup: UIStackView!
    
    
    //Row 4 Field
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var streetAddressGroup: UIStackView!
    
    
    //Row 5 Fields
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var cityGroup: UIStackView!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var stateGroup: UIStackView!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var zipCodeGroup: UIStackView!
    
    //Bottom Buttons
    @IBOutlet weak var generatePassButton: UIButton!
    @IBOutlet weak var populateDataButton: UIButton!
    
    
    //Constraints
    @IBOutlet weak var mainStackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainStackViewTopConstraint: NSLayoutConstraint!
    
    //Outlet collection - contains all input fields
    @IBOutlet var allFields: [UIView]!
    //Outlet collection - contains all input field groups (stack view, including labels)
    @IBOutlet var allFieldGroups: [UIView]!
    
    //General Variables
    //Rename this one to something to do with responder fields!!
    var currentlyActiveTextField: UITextField?
    var currentEntrantSubType: EntrantSubType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickers()
        configureTextFields()
        
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
        setFieldsUserEnabled(to: false, for: allFieldGroups)
        
        if let entrantType = EntrantType(rawValue: sender.tag) {
            displayEntrantSubtypes(for: entrantType)
        }
        
        //Disable Generate Pass & Populate Data buttons
        setFieldsUserEnabled(to: false, for: [generatePassButton, populateDataButton])
        
        self.currentEntrantSubType = nil
    }
    
    func displayEntrantSubtypes(for entrantType: EntrantType) {
        
        guard let subTypeButtonTitles = entrantSubTypeButtonTitles(for: entrantType) else { return }
        
        for (buttonTitle, entrantSubType) in subTypeButtonTitles {
            let button = EntrantSubTypeButton(entrantSubType: entrantSubType)
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.setTitle(buttonTitle, for: .normal)
            button.backgroundColor = .blue
            button.addTarget(self, action: #selector(ViewController.entrantSubTypeSelected(button:)), for: .touchUpInside)
            entrantSubTypeStackView.addArrangedSubview(button)
        }
    }
    
    //Returns the button titles and associated entrant sub-type to allow buttons to be labelled and hold information about the entrant class to be later generated.
    //Tuples array rather than dictionary to preserve order
    func entrantSubTypeButtonTitles(for entrantType: EntrantType) -> [(String, EntrantSubType)]? {
        switch entrantType {
        case .guest: return [
            ("Child", .childGuest),
            ("Classic", .classicGuest),
            ("Senior", .seniorGuest),
            ("VIP", .vipGuest),
            ("Senior Pass", .seasonPassGuest)]
        case .employee: return [
            ("Food Services", .hourlyEmployee_foodServices),
            ("Ride Services", .hourlyEmployee_rideServices),
            ("Maintenance", .hourlyEmployee_maintenance)]
        case .manager: return [
            ("Shift", .manager_shift),
            ("Senior", .manager_senior),
            ("General", .manager_general)]
        case .contractor: return [
            ("Contractor", .contractor)]
        case .vendor: return [
            ("Vendor", .vendor)]
        }
    }
    
    @objc func entrantSubTypeSelected(button: EntrantSubTypeButton!) {
        //Set font size to normal for all subtype buttons & disable all information fields
        for view in entrantSubTypeStackView.arrangedSubviews {
            if let button = view as? EntrantSubTypeButton {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
            }
        }
        setFieldsUserEnabled(to: false, for: allFieldGroups)
        
        //Emphasize this selected subtype button & enable appropriate fields for selected subtype
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        setFieldsUserEnabled(to: true, for: requiredFields(for: button.entrantSubType))
        
        //Enable Generate Pass & Populate Data buttons (if at least one field active)
        setFieldsUserEnabled(to: true, for: [generatePassButton])
        setFieldsUserEnabled(to: false, for: [populateDataButton])
        for field in allFields {
            if field.isUserInteractionEnabled {
                setFieldsUserEnabled(to: true, for: [populateDataButton])
                break
            }
        }
        
        self.currentEntrantSubType = button.entrantSubType
    }
    
    @IBAction func generatePassbuttonPressed(_ sender: UIButton) {
        
        let entrantInformation = generateInformationObject()
        print("About to dump entrant Info")
        dump(entrantInformation)
    }
    
    @IBAction func populateDataButtonPressed(_ sender: UIButton) {
        //Cycle through the fields and populate if userEnabled
        for inputField in allFields {
            if inputField.isUserInteractionEnabled == true, let field = Field(rawValue: inputField.tag) {
                setTestData(for: field)
            }
        }
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
        datePicker.setDefaultData()
        
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
        guard let field = Field(rawValue: pickerView.tag) else { return 0 }
        
        switch field {
        case .project: return ProjectDataSource.projects.count
        case .company: return VendorCompany.allCases.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let field = Field(rawValue: pickerView.tag) else { return nil }
        
        switch field {
        case .project: return String(ProjectDataSource.projects[row])
        case .company: return VendorCompany.allCasesAsStrings()[row]
        default: return nil
        }
    }
}

//MARK:- Text Fields
extension ViewController: UITextFieldDelegate {
    
    func configureTextFields() {
        ssnTextField.delegate = self
        zipCodeTextField.delegate = self
        
        //Keyboard observers:
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        //Check if one of the lower fields is currently the first responder.
        if let currentActiveField = currentlyActiveTextField, currentActiveField.isFirstResponder {
            //Get the keyboard frame (for the height)
            if let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                //Move Main StackView up to make room for keyboard
                let frame = keyboardFrame.cgRectValue
                mainStackViewBottomConstraint.constant = mainStackViewBottomConstraint.constant + frame.size.height/3
                mainStackViewTopConstraint.constant = mainStackViewTopConstraint.constant - frame.size.height/3
                UIView.animate(withDuration: 0.8) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = Field(rawValue: textField.tag) {
            if [Field.city, Field.state, Field.zipCode].contains(field) {
                currentlyActiveTextField = textField
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        currentlyActiveTextField = nil
        return true
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        //Restore Main StackView constraints
        mainStackViewBottomConstraint.constant = 20
        mainStackViewTopConstraint.constant = 22
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}

//MARK:- Helper functions and extensions

extension ViewController {
    
    //Called with field groups.  Set children values accordingly.
    func setFieldsUserEnabled(to boolean: Bool, for fields: [UIView]) {
        for field in fields {
            field.isUserInteractionEnabled = boolean
            field.alpha = boolean ? 1.0 : 0.5
            for subField in field.subviews {
                subField.isUserInteractionEnabled = boolean
                subField.alpha = boolean ? 1.0 : 0.5
            }
        }
    }
    
    // Return the fields to be enabled given the entrant sub type button selected
    func requiredFields(for subType: EntrantSubType) -> [UIView] {
        let baseFieldGroups: [UIView] = [firstNameGroup, lastNameGroup, streetAddressGroup, cityGroup, stateGroup, zipCodeGroup, datePickerGroup]
        switch subType {
        case .classicGuest, .vipGuest:
            return []
        case .childGuest:
            return [datePickerGroup]
        case .hourlyEmployee_foodServices, .hourlyEmployee_maintenance, .hourlyEmployee_rideServices, .manager_general, .manager_senior, .manager_shift:
            return baseFieldGroups + [ssnGroup]
        case .seasonPassGuest:
            return baseFieldGroups
        case .seniorGuest:
            return [firstNameGroup, lastNameGroup, datePickerGroup]
        case .contractor:
            return baseFieldGroups + [ssnGroup, projectPickerGroup]
        case .vendor:
            return [firstNameGroup, lastNameGroup, companyPickerGroup, datePickerGroup]
        }
    }
    
    func setTestData(for field: Field) {
        switch field {
        case .dateOfBirth:      datePicker.setTestData()
        case .ssn:              ssnTextField.text = "123456789"
        case .firstName:        firstNameTextField.text = "Jamie"
        case .lastName:         lastNameTextField.text = "Lanister"
        case .company:          companyPicker.selectRow(2, inComponent: 0, animated: true)
        case .project:          projectPicker.selectRow(2, inComponent: 0, animated: true)
        case .streetAddress:    streetAddressTextField.text = "24 Flea Bottom Avenue"
        case .city:             cityTextField.text = "Kings Landing"
        case .state:            stateTextField.text = "Westeros"
        case .zipCode:          zipCodeTextField.text = "54321"
        }
    }
    
    //Cycle through the fields and extract data if userEnabled
    func generateInformationObject() -> EntrantInformation? {
        
        //Ensure there is a subType (should always be the case)
        guard let selectedEntrantSubType = self.currentEntrantSubType else { return nil }
        
        //No information required for classic and vip guests
        if selectedEntrantSubType == .classicGuest || selectedEntrantSubType == .vipGuest { return nil }
        
        //Should have a date
        let dateOfBirth = datePicker.date
        var ssn: Int? {
            if let ssnText = self.getTextFieldValueIfEnabled(field: self.ssnTextField) {
                return Int(ssnText)
            } else {
                return nil
            }
        }
        let firstName = getTextFieldValueIfEnabled(field: firstNameTextField)
        let lastName = getTextFieldValueIfEnabled(field: lastNameTextField)
        let streetAddress = getTextFieldValueIfEnabled(field: streetAddressTextField)
        let city = getTextFieldValueIfEnabled(field: cityTextField)
        let state = getTextFieldValueIfEnabled(field: stateTextField)
        let zipCode = getTextFieldValueIfEnabled(field: zipCodeTextField)
        
        let projectNumber = projectPicker.isUserInteractionEnabled ? projectPicker.selectedRow(inComponent: 0) : nil
        let company = companyPicker.isUserInteractionEnabled ? VendorCompany.vendorForRow(companyPicker.selectedRow(inComponent: 0))  : nil
        
        return EntrantInformation(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: ssn, projectNumber: projectNumber, company: company, dateOfBirth: dateOfBirth)
    }
    
    func getTextFieldValueIfEnabled (field: UITextField) -> String? {
        return field.isUserInteractionEnabled ? field.text : nil
    }
}
