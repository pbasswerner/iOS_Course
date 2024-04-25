//
//  AddNewContactViewController.swift
//  WA4_Basswerner_8001
//
//  Created by Paula Basswerner on 2/14/24.
//

import UIKit

class AddNewContactViewController: UIViewController {
    
    var delegate: ViewController!
    let addNewContactScreen = AddNewContactScreen()
    var contact: Contact =  Contact()
    
    let phoneTypesPickerData = ["Cell", "Home", "Work"]
    var selectedPhoneType = "Cell"
    
    override func loadView() {
        view = addNewContactScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addNewContactScreen.picker.delegate = self
        addNewContactScreen.picker.dataSource = self
        
        addNewContactScreen.emailTextField.keyboardType = .emailAddress
        addNewContactScreen.numberTextField.keyboardType = .numberPad
        addNewContactScreen.zipTextField.keyboardType = .numberPad
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSaveProfileButtonClicked))
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        
    }
    
    @objc func onSaveProfileButtonClicked(){
        let validName:Bool = isValidName()
        let validEmail:Bool = isValidEmail()
        let validPhoneNumber:Bool = isValidPhoneNumber()
        let validAddress:Bool = isValidAddress()
        let validCityState:Bool = isValidCityState()
        let validZip:Bool = isValidZip()
        
        if(validEmail && validName && validPhoneNumber && validAddress && validCityState && validZip){
            delegate.delegateOnAddContact(contact: self.contact)
            pushToNextViewController(self)
            
        }
        
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func isValidName() -> Bool {
        let name = addNewContactScreen.nameTextField.text
        if let unwrappedName = name{
            if(!unwrappedName.isEmpty){
                updateContact(fieldToUpdate: "name", value: unwrappedName, contact: contact)
                return true
            } else{
                showAlert(withMessage: "Invalid Name Input")
                return false
            }
        }
        return false
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        if let unwrappedEmail = addNewContactScreen.emailTextField.text{
            if(!unwrappedEmail.isEmpty && emailTest.evaluate(with: unwrappedEmail)){
                updateContact(fieldToUpdate: "email", value: unwrappedEmail, contact:contact)
                return true
            } else{
                showAlert(withMessage: "Invalid Email address")
                return false
            }
        }
        return false
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}([0-9]{10,15})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        if let unwrappedPhoneNumber = addNewContactScreen.numberTextField.text{
            if(!unwrappedPhoneNumber.isEmpty && phoneTest.evaluate(with: unwrappedPhoneNumber)){
                updateContact(fieldToUpdate: "phoneNumber", value: unwrappedPhoneNumber, contact: contact)
                return true
            } else{
                showAlert(withMessage: "Invalid Phone Number")
                return false
            }
        }
        return false
    }
    
    func isValidAddress() -> Bool {
        let address = addNewContactScreen.addressTextField.text
        if let unwrappedAddress = address{
            if(!unwrappedAddress.isEmpty){
                updateContact(fieldToUpdate: "address", value: unwrappedAddress, contact: contact)
                return true
            } else{
                showAlert(withMessage: "Invalid Address")
                return false
            }
        }
        return false
    }
    
    func isValidCityState() -> Bool {
        let cityState = addNewContactScreen.cityStateTextField.text
        if let unwrappedCityState = cityState{
            if(!unwrappedCityState.isEmpty){
                updateContact(fieldToUpdate: "cityState", value: unwrappedCityState, contact: contact)
                return true
            } else{
                showAlert(withMessage: "Invalid City and State")
                return false
            }
        }
        return false
    }
    
    func isValidZip() -> Bool {
        let zipRegex = "^\\d{5}$"
        let zipTest = NSPredicate(format: "SELF MATCHES %@", zipRegex)
        
        
        if let unwrappedZip = addNewContactScreen.zipTextField.text{
            if(!unwrappedZip.isEmpty && zipTest.evaluate(with: unwrappedZip)){
                updateContact(fieldToUpdate: "zip", value: unwrappedZip, contact: contact)
                return true
            } else{
                showAlert(withMessage: "Invalid Zip Code")
                return false
            }
        }
        return false
    }
    
    
    func updateContact(fieldToUpdate: String, value: String, contact: Contact){
        if fieldToUpdate == "name"{
            self.contact.name = value
        }
        if fieldToUpdate == "email"{
            self.contact.email = value
        }
        if fieldToUpdate == "phoneType"{
            self.contact.phoneType = value
        }
        if fieldToUpdate == "phoneNumber"{
            self.contact.phoneNumber = value
        }
        if fieldToUpdate == "address"{
            self.contact.address = value
        }
        if fieldToUpdate == "cityState"{
            self.contact.cityState = value
        }
        if fieldToUpdate == "zip"{
            self.contact.zip = value
        }
    }
    
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pushToNextViewController(_ sender: Any) {
        
        //
        //        let backButton = UIBarButtonItem()
        //        backButton.title = "Create Profile"
        //        self.navigationItem.backBarButtonItem = backButton
        
        
        let viewController = ViewController()
        viewController.contacts.append(contact)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}

extension AddNewContactViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return phoneTypesPickerData.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedPhoneType = phoneTypesPickerData[row]
        updateContact(fieldToUpdate: "phoneType", value: selectedPhoneType, contact: contact)
        return phoneTypesPickerData[row]
    }
    
}

