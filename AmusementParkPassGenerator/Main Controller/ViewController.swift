//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Gavin Butler on 28-07-2019.
//  Copyright © 2019 Gavin Butler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let inputValidator = InputValidation()  //Manage Text Field validation where required
    
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
    var currentEntrant: Entrant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePickers()      //Set up Picker mode, delegate, datasource
        configureTextFields()   //Configure delegates and functions for keyboard interactions
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
        
        //Display entrant sub type buttons based on entrant type selected
        if let entrantType = EntrantType(rawValue: sender.tag) {
            displayEntrantSubtypes(for: entrantType)
        }
        
        //Disable Generate Pass & Populate Data buttons
        setFieldsUserEnabled(to: false, for: [generatePassButton, populateDataButton])
        
        //Reset the currently active sub type
        self.currentEntrantSubType = nil
    }
    
    func displayEntrantSubtypes(for entrantType: EntrantType) {
        
        //Retrieve sub types for entrant type and display corresponding buttons in the sub type stackview.  Save entrant sub type with the button.
        for entrantSubType in entrantType.subTypes() {
            let button = EntrantSubTypeButton(entrantSubType: entrantSubType)
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.setTitle(entrantSubType.rawValue, for: .normal)
            button.backgroundColor = UIColor(red: 67/255, green: 53/255, blue: 82/255, alpha: 1.0)
            button.addTarget(self, action: #selector(ViewController.entrantSubTypeSelected(button:)), for: .touchUpInside)
            entrantSubTypeStackView.addArrangedSubview(button)
        }
    }
    
    @objc func entrantSubTypeSelected(button: EntrantSubTypeButton!) {
        //Reset font size to normal for all subtype buttons & disable all information fields in preparation for highlighting appropriate button and fields.
        for view in entrantSubTypeStackView.arrangedSubviews {
            if let button = view as? EntrantSubTypeButton {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
            }
        }
        setFieldsUserEnabled(to: false, for: allFieldGroups)
        
        //Emphasize this selected subtype button & enable appropriate fields for selected subtype
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        setFieldsUserEnabled(to: true, for: requiredFields(for: button.entrantSubType))
        
        //Enable Generate Pass button & Populate Data button if at least one field active
        setFieldsUserEnabled(to: true, for: [generatePassButton])
        setFieldsUserEnabled(to: false, for: [populateDataButton])
        for field in allFields {
            if field.isUserInteractionEnabled {
                setFieldsUserEnabled(to: true, for: [populateDataButton])
                break
            }
        }
        
        //Save the sub type to the view controller, as current sub type.
        self.currentEntrantSubType = button.entrantSubType
    }
    
    @IBAction func generatePassbuttonPressed(_ sender: UIButton) {
        
        //Generate the information object from enabled fields & ensure we have a current sub type
        let entrantInformation = generateInformationObject()
        guard let entrantSubType = currentEntrantSubType else { return }
        
        //Create Entrant of sub type and with information, and present any initialiser errors in an alert:
        do {
            self.currentEntrant = try createEntrant(ofSubType : entrantSubType, with: entrantInformation)
        }
        catch let error as InformationError {
            let alertController = UIAlertController(title: error.title(), message: error.message(), preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            
            present(alertController, animated: true, completion: nil)
        } catch let error {              //Unknown error encountered
            fatalError("\(error.localizedDescription)")
        }
    }
    
    @IBAction func populateDataButtonPressed(_ sender: UIButton) {
        //Cycle through the fields and populate test data if userEnabled
        for inputField in allFields {
            if inputField.isUserInteractionEnabled == true, let field = Field(rawValue: inputField.tag) {
                setTestData(for: field)
            }
        }
    }
    
    //Remove this class as observer on deinitialization
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
        
        //Check tag to ensure this is a recognizable field, else return 0 as number of rows
        guard let field = Field(rawValue: pickerView.tag) else { return 0 }
        
        //Return number of data rows from class property counts for appropriate picker.
        switch field {
        case .project: return ProjectDataSource.projects.count
        case .company: return VendorCompany.allCases.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //Check tag to ensure this is a recognizable field, else return nil indicating no data
        guard let field = Field(rawValue: pickerView.tag) else { return nil }
        
        //Return the data for the title of the requested row
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
        //To restrict fields to digits and to a certain number.  See Input Validation Class.
        ssnTextField.delegate = self
        zipCodeTextField.delegate = self
        
        //Keyboard observers:
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Control validation for ssn and zipCode text fields.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let fieldCharacterSet = CharacterSet(charactersIn: string)
        
        //Acknowledgement - hackingwithswift.com
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch textField {
        case ssnTextField:  //Restrict to digits and 9 characters max
            return inputValidator.allowedSSNCharacters.isSuperset(of: fieldCharacterSet) && updatedText.count <= inputValidator.ssnMaxLength
        case zipCodeTextField:  //Restrict to digits and 5 characters max
            return inputValidator.allowedZipCodeCharacters.isSuperset(of: fieldCharacterSet) && updatedText.count <= inputValidator.zipCodeMaxLength
        default:
            return true
        }
    }
    
    //Move main stackview up if lower fields selected for editing as they will conflict with the keyboard.
    @objc func keyboardWillShow(_ notification: Notification) {
        //Check if one of the lower fields is currently the first responder.
        if let currentActiveField = currentlyActiveTextField, currentActiveField.isFirstResponder {
            //Get the keyboard frame (for the height)
            if let info = notification.userInfo, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                //Move Main StackView up to make room for keyboard
                let frame = keyboardFrame.cgRectValue
                mainStackViewBottomConstraint.constant = mainStackViewBottomConstraint.constant + frame.size.height/2
                mainStackViewTopConstraint.constant = mainStackViewTopConstraint.constant - frame.size.height/2
                UIView.animate(withDuration: 0.8) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    //Set as currently active text field if one of the lowest 3 fields.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let field = Field(rawValue: textField.tag) {
            if [Field.city, Field.state, Field.zipCode].contains(field) {
                currentlyActiveTextField = textField
            }
        }
    }
    
    //Reset the currently active text filed to nil when finished editing the text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        currentlyActiveTextField = nil
        return true
    }
    
    //Restore Main StackView constraints when keyboard hides.
    @objc func keyboardWillHide(_ notification: Notification) {
        mainStackViewBottomConstraint.constant = 20
        mainStackViewTopConstraint.constant = 22
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}

//MARK:- Segue

extension ViewController {
    
    //Check to verify specific expected segue, get destination View Controller and set it's entrant.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewPassSegue", let createNewPassViewController = segue.destination as? PassTesterViewController, let entrant = currentEntrant {
            createNewPassViewController.entrant = entrant
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
        //Base field groups simply lists common base fields - to avoid too much duplication in the switch.
        let baseFieldGroups: [UIView] = [firstNameGroup, lastNameGroup, streetAddressGroup, cityGroup, stateGroup, zipCodeGroup, datePickerGroup]
        
        //Add or specify specific required fields basted on the sub type.
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
    
    // Set test data for a particular information field - called only if that field is active according to the sub type chosen.
    func setTestData(for activField: Field) {
        switch activField {
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
        
        
        //Should always have a date
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
        
        var projectNumber: Int? {
            if projectPicker.isUserInteractionEnabled {
                let pickerRow = projectPicker.selectedRow(inComponent: 0)
                return ProjectDataSource.projects[pickerRow]
            } else {
                return nil
            }
        }
        let company = companyPicker.isUserInteractionEnabled ? VendorCompany.vendorForRow(companyPicker.selectedRow(inComponent: 0))  : nil
        
        //Create & return the entrant information object
        return EntrantInformation(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: ssn, projectNumber: projectNumber, company: company, dateOfBirth: dateOfBirth)
    }
    
    //Return the text field value if it is enabled and contains text
    func getTextFieldValueIfEnabled (field: UITextField) -> String? {
        return field.isUserInteractionEnabled && field.text != "" ? field.text : nil
    }
    
    //Create correct entrant basted on sub type and with information if required, and propogate error if information is missing.
    func createEntrant(ofSubType subType: EntrantSubType, with entrantInformation: EntrantInformation?) throws -> Entrant {
        let entrant: Entrant
        
        //This section deals with creation of entrants requiring entrant information
        if let information = entrantInformation {
            switch subType {
            case .childGuest:
                entrant = try FreeChildGuest(entrantInformation: information)  //Need to get rid of the forced unwrapping
            case .seniorGuest:
                entrant = try SeniorGuest(entrantInformation: information)
            case .seasonPassGuest:
                entrant = try SeasonPassGuest(entrantInformation: information)
            case .hourlyEmployee_foodServices:
                entrant = try HourlyEmployee(ofType: .foodServices, entrantInformation: information)
            case .hourlyEmployee_rideServices:
                entrant = try HourlyEmployee(ofType: . rideServices, entrantInformation: information)
            case .hourlyEmployee_maintenance:
                entrant = try HourlyEmployee(ofType: . maintenance, entrantInformation: information)
            case .manager_shift:
                entrant = try Manager(entrantInformation: information, managementTier: .shiftManager)
            case .manager_senior:
                entrant = try Manager(entrantInformation: information, managementTier: .seniorManager)
            case .manager_general:
                entrant = try Manager(entrantInformation: information, managementTier: .generalManager)
            case .contractor:
                entrant = try Contractor(entrantInformation: information)
            case .vendor:
                entrant = try Vendor(entrantInformation: information)
            default: fatalError("Entrant subType not found for non-nil information")
            }
        } else {    //Should only be nil for classic and vip guests
            switch subType {
            case .classicGuest:
                entrant = ClassicGuest()
            case .vipGuest:
                entrant = VIPGuest()
            default: fatalError("Guest information not required")
            }
        }
        return entrant
    }
}
