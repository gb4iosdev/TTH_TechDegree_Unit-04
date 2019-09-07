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
    
    //Constraints
    @IBOutlet weak var mainStackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainStackViewTopConstraint: NSLayoutConstraint!
    
    //Outlet collection - contains all input fields
    @IBOutlet var allFields: [UIView]!
    //Outlet collection - contains all input field groups (stack view, including labels)
    @IBOutlet var allFieldGroups: [UIView]!
    
    
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
        
        displayEntrantSubtypes(sender.tag)
        
        //Disable Generate Pass button
    }
    
    func displayEntrantSubtypes(_ entrantTypeTag: Int) {
        
        guard let subTypeButtonTitles = entrantSubTypeButtonTitles(for: entrantTypeTag) else { return }
        
        for (buttonTitle, entrantSubType) in subTypeButtonTitles {
            let button = EntrantSubTypeButton(entrantSubType: entrantSubType)
            button.heightAnchor.constraint(equalToConstant: 55).isActive = true
            button.setTitle(buttonTitle, for: .normal)
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
        print("class to generate is: \(String(describing: button.entrantSubType))")
        for view in entrantSubTypeStackView.arrangedSubviews {
            if let button = view as? EntrantSubTypeButton {
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
            }
        }
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
        setFieldsUserEnabled(to: false, for: allFieldGroups)
        setFieldsUserEnabled(to: true, for: requiredFields(for: button.entrantSubType))
    }
    
    @IBAction func generatePassbuttonPressed(_ sender: UIButton) {
        
        //createInformationObject()
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
        //Check that first responder is one of the lower text fields
        for aView in view.recursiveSubViews() {
            if aView.isFirstResponder && aView is UITextField && (aView === zipCodeTextField || aView === stateTextField || aView === cityTextField) {
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
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
    
    func setFieldsUserEnabled(to boolean: Bool, for fields: [UIView]) {
        for field in fields {
            field.isUserInteractionEnabled = boolean
            field.alpha = boolean ? 1.0 : 0.5
        }
    }
    
    func requiredFields(for subType: EntrantSubType) -> [UIView] {
        switch subType {
        case .classicGuest, .vipGuest:
            return []
        case .childGuest:
            return [datePickerGroup]
        case .hourlyEmployee(.foodServices), .hourlyEmployee(.maintenance), .hourlyEmployee(.rideServices):
            return [datePickerGroup, firstNameGroup, lastNameGroup, streetAddressGroup, cityGroup, stateGroup, zipCodeGroup, ssnGroup]
        case .seniorGuest:
            return [datePickerGroup, firstNameGroup, lastNameGroup]
        default:
            return []
        }
    }
    
}

extension UIView {
    func recursiveSubViews() -> [UIView] {
        return subviews + subviews.flatMap { $0.recursiveSubViews() }
    }
}
