//
//  AddNewContactViewController.swift
//  WA5_Basswerner_8001
//
//  Created by Paula Basswerner on 4/25/24.
//
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
        title = "Add Contact"
        
        addNewContactScreen.emailTextField.keyboardType = .emailAddress
        addNewContactScreen.numberTextField.keyboardType = .numberPad
        addNewContactScreen.zipTextField.keyboardType = .numberPad
        
        updateContact(fieldToUpdate: "phoneType", value: selectedPhoneType, contact: &contact)// initialize
        
        addNewContactScreen.saveProfileButton.addTarget(self, action: #selector(onSaveProfileButtonClicked), for: .touchUpInside)
        addNewContactScreen.phoneTypeButton.addTarget(self, action: #selector(phoneTypeButtonTapped), for: .touchUpInside)
        addNewContactScreen.imagePickerButton.addTarget(self, action: #selector(presentImagePickerActionSheet), for: .touchUpInside)
        
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
    
    @objc func phoneTypeButtonTapped() {
        let alert = UIAlertController(title: "Select Phone Type", message: nil, preferredStyle: .actionSheet)
        
        phoneTypesPickerData.forEach { [weak self] type in
            alert.addAction(UIAlertAction(title: type, style: .default, handler: { _ in
                guard let strongSelf = self else { return }
                strongSelf.selectedPhoneType = type
                strongSelf.addNewContactScreen.phoneTypeButton.setTitle(type, for: .normal)
                strongSelf.updateContact(fieldToUpdate: "phoneType", value: type, contact: &strongSelf.contact)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
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
                updateContact(fieldToUpdate: "name", value: unwrappedName, contact: &contact)
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
                updateContact(fieldToUpdate: "email", value: unwrappedEmail, contact:&contact)
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
                updateContact(fieldToUpdate: "phoneNumber", value: unwrappedPhoneNumber, contact: &contact)
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
                updateContact(fieldToUpdate: "address", value: unwrappedAddress, contact: &contact)
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
                updateContact(fieldToUpdate: "cityState", value: unwrappedCityState, contact: &contact)
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
                updateContact(fieldToUpdate: "zip", value: unwrappedZip, contact: &contact)
                return true
            } else{
                showAlert(withMessage: "Invalid Zip Code")
                return false
            }
        }
        return false
    }
    
    func updateContact(fieldToUpdate: String, value: String, contact: inout Contact) {
        switch fieldToUpdate {
        case "name":
            contact.name = value
        case "email":
            contact.email = value
        case "phoneType":
            contact.phoneType = value
        case "phoneNumber":
            contact.phoneNumber = value
        case "address":
            contact.address = value
        case "cityState":
            contact.cityState = value
        case "zip":
            contact.zip = value
        default:
            break
        }
    }
    
    func showAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pushToNextViewController(_ sender: Any) {
        
        let viewController = ViewController()
        viewController.contacts.append(contact)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

import UIKit

extension AddNewContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Function to present action sheet for camera or photo library
    @objc func presentImagePickerActionSheet() {
        let actionSheet = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [unowned self] _ in
                self.presentImagePicker(sourceType: .camera)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Choose from Gallery", style: .default, handler: { [unowned self] _ in
            self.presentImagePicker(sourceType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    // Function to present the image picker
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        
        handleSelectedImage(image)
        picker.dismiss(animated: true)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    @objc func handleSelectedImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) ?? image.pngData() {
            do {
                // Generate a unique filename for the image
                let filename = UUID().uuidString
                let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent(filename)
                
                // Write the data to the file
                try imageData.write(to: fileURL)
                
                // Update the contact's profile image path
                contact.profileImagePath = fileURL.path
                
                // Update the imagePickerButton to show the selected image
                addNewContactScreen.imagePickerButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                
            } catch {
                print("Error saving image: \(error)")
            }
        }
    }
}




