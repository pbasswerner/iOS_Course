//
//  ViewController.swift
//  WA3_Basswerner_8001
//
//  Created by Paula Basswerner on 2/7/24.
//

import UIKit

class ViewController: UIViewController {

    let landingScreen = LandingScreen()
    var package: Package = Package()
    let phoneTypesPickerData = ["Cell", "Home", "Work"]
    var selectedPhoneType = "Cell"
    
    public struct Package {
        var name:String?
        var email:String?
        var phoneType:String?
        var phoneNumber: String?
        var address:String?
        var cityState:String?
        var zip:String?
        
        init(name: String? = nil, email: String? = nil, phoneType: String? = nil, phoneNumber: String? = nil, address: String? = nil, cityState: String? = nil, zip: String? = nil) {
            self.name = name
            self.email = email
            self.phoneType = phoneType
            self.phoneNumber = phoneNumber
            self.address = address
            self.cityState = cityState
            self.zip = zip
        }
    }
    
    override func loadView() {
        view = landingScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        landingScreen.picker.delegate = self
        landingScreen.picker.dataSource = self
        
        landingScreen.emailTextField.keyboardType = .emailAddress
        landingScreen.numberTextField.keyboardType = .numberPad
        landingScreen.zipTextField.keyboardType = .numberPad
        
        landingScreen.showProfileButton.addTarget(self, action: #selector(onShowProfileButtonClicked), for: .touchUpInside)
    }

    
    @objc func onShowProfileButtonClicked(){
        let validName:Bool = isValidName()
        let validEmail:Bool = isValidEmail()
        let validPhoneNumber:Bool = isValidPhoneNumber()
        let validAddress:Bool = isValidAddress()
        let validCityState:Bool = isValidCityState()
        let validZip:Bool = isValidZip()
        
        if(validEmail && validName && validPhoneNumber && validAddress && validCityState && validZip){
          pushToNextViewController(self)
        }

    }
    func isValidName() -> Bool {
        let name = landingScreen.nameTextField.text
        if let unwrappedName = name{
            if(!unwrappedName.isEmpty){
                updatePackage(fieldToUpdate: "name", value: unwrappedName, package: package)
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
        
        if let unwrappedEmail = landingScreen.emailTextField.text{
            if(!unwrappedEmail.isEmpty && emailTest.evaluate(with: unwrappedEmail)){
                updatePackage(fieldToUpdate: "email", value: unwrappedEmail, package: package)
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
        
        if let unwrappedPhoneNumber = landingScreen.numberTextField.text{
            if(!unwrappedPhoneNumber.isEmpty && phoneTest.evaluate(with: unwrappedPhoneNumber)){
                updatePackage(fieldToUpdate: "phoneNumber", value: unwrappedPhoneNumber, package: package)
                return true
            } else{
                showAlert(withMessage: "Invalid Phone Number")
                return false
            }
        }
        return false
    }
    
    func isValidAddress() -> Bool {
        let address = landingScreen.addressTextField.text
        if let unwrappedAddress = address{
            if(!unwrappedAddress.isEmpty){
                updatePackage(fieldToUpdate: "address", value: unwrappedAddress, package: package)
                return true
            } else{
                showAlert(withMessage: "Invalid Address")
                return false
            }
        }
        return false
    }
    
    func isValidCityState() -> Bool {
        let cityState = landingScreen.cityStateTextField.text
        if let unwrappedCityState = cityState{
            if(!unwrappedCityState.isEmpty){
                updatePackage(fieldToUpdate: "cityState", value: unwrappedCityState, package: package)
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
        
    
        if let unwrappedZip = landingScreen.zipTextField.text{
            if(!unwrappedZip.isEmpty && zipTest.evaluate(with: unwrappedZip)){
                updatePackage(fieldToUpdate: "zip", value: unwrappedZip, package: package)
                return true
            } else{
                showAlert(withMessage: "Invalid Zip Code")
                return false
            }
        }
        return false
    }
    
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updatePackage(fieldToUpdate: String, value: String, package: Package){
        if fieldToUpdate == "name"{
            self.package.name = value
        }
        if fieldToUpdate == "email"{
            self.package.email = value
        }
        if fieldToUpdate == "phoneType"{
            self.package.phoneType = value
        }
        if fieldToUpdate == "phoneNumber"{
            self.package.phoneNumber = value
        }
        if fieldToUpdate == "address"{
            self.package.address = value
        }
        if fieldToUpdate == "cityState"{
            self.package.cityState = value
        }
        if fieldToUpdate == "zip"{
            self.package.zip = value
        }
    }
    
    @IBAction func pushToNextViewController(_ sender: Any) {
        let profileScreenViewController = ProfileScreenViewController()
        profileScreenViewController.receivedPackage = package
        print("Phone Type: \(String(describing: profileScreenViewController.receivedPackage.phoneType))")
        
        let backButton = UIBarButtonItem()
        backButton.title = "Create Profile"
        self.navigationItem.backBarButtonItem = backButton
        
        navigationController?.pushViewController(profileScreenViewController, animated: true)
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return phoneTypesPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          selectedPhoneType = phoneTypesPickerData[row]
        updatePackage(fieldToUpdate: "phoneType", value: selectedPhoneType, package: self.package)
      }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel

        if let v = view as? UILabel {
            label = v
        } else {
            label = UILabel()
        }

        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16) // Set your custom font size here

        label.text = phoneTypesPickerData[row]

        return label
    }

}

