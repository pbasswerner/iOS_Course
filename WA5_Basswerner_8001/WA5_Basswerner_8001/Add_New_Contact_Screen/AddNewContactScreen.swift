//
//  AddNewContactScreen.swift
//  WA5_Basswerner_8001
//
//  Created by Paula Basswerner
//

import UIKit

class AddNewContactScreen: UIView {
    
    
    var nameTextField: UITextField!
    var profileImageLabel: UILabel!
    var emailTextField: UITextField!
    var numberTextField: UITextField!
    var addressTextField: UITextField!
    var cityStateTextField: UITextField!
    var zipTextField: UITextField!
    var saveProfileButton: UIButton!
    var phoneTypeButton: UIButton!
    var imagePickerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUpPhoneTypeButton()
        setUpNameTextField()
        setUpEmailTextField()
        setUpNumberTextField()
        setUpAddressTextField()
        setUpCityStateTextField()
        setUpZipTextField()
        setUpSaveProfileButton()
        setUpImagePickerButton()
        initConstraints()
    }
    
    func setUpImagePickerButton() {
        
        imagePickerButton = UIButton(type: .system)
        imagePickerButton.setTitleColor(.black, for: .normal)
        imagePickerButton.tintColor = .black
        imagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        imagePickerButton.setImage(UIImage(systemName: "person.fill"), for: .normal)
        imagePickerButton.clipsToBounds = true
        imagePickerButton.contentMode = .scaleAspectFill
        imagePickerButton.contentHorizontalAlignment = .fill
        imagePickerButton.contentVerticalAlignment = .fill
        addSubview(imagePickerButton)
    }
    
    func setUpNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.font = UIFont.systemFont(ofSize: 16)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.borderStyle = .roundedRect
        self.addSubview(nameTextField)
    }
    
    func setUpPhoneTypeButton() {
        phoneTypeButton = UIButton(type: .system)
        phoneTypeButton.setTitle("Cell", for: .normal) // Initial title
        phoneTypeButton.setTitleColor(.systemBlue, for: .normal)
        phoneTypeButton.backgroundColor = .clear // Or any other color
        phoneTypeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phoneTypeButton)
    }
    
    
    func setUpEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.borderStyle = .roundedRect
        self.addSubview(emailTextField)
    }
    
    func setUpNumberTextField() {
        numberTextField = UITextField()
        numberTextField.placeholder = "Phone Number"
        numberTextField.font = UIFont.systemFont(ofSize: 16)
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.borderStyle = .roundedRect
        self.addSubview(numberTextField)
    }
    
    func setUpAddressTextField() {
        addressTextField = UITextField()
        addressTextField.placeholder = "Address"
        addressTextField.font = UIFont.systemFont(ofSize: 16)
        addressTextField.translatesAutoresizingMaskIntoConstraints = false
        addressTextField.borderStyle = .roundedRect
        self.addSubview(addressTextField)
    }
    
    func setUpCityStateTextField() {
        cityStateTextField = UITextField()
        cityStateTextField.placeholder = "City, State"
        cityStateTextField.font = UIFont.systemFont(ofSize: 16)
        cityStateTextField.translatesAutoresizingMaskIntoConstraints = false
        cityStateTextField.borderStyle = .roundedRect
        self.addSubview(cityStateTextField)
    }
    
    func setUpZipTextField() {
        zipTextField = UITextField()
        zipTextField.placeholder = "Zip"
        zipTextField.font = UIFont.systemFont(ofSize: 16)
        zipTextField.translatesAutoresizingMaskIntoConstraints = false
        zipTextField.borderStyle = .roundedRect
        self.addSubview(zipTextField)
    }
    
    func setUpSaveProfileButton() {
        saveProfileButton = UIButton()
        saveProfileButton.setTitle("Save", for: .normal)
        saveProfileButton.setTitleColor(.systemBlue, for: .normal)
        saveProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(saveProfileButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            nameTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            
            // Constraints for the image picker button
            imagePickerButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 20),
            imagePickerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imagePickerButton.widthAnchor.constraint(equalToConstant: 80),
            imagePickerButton.heightAnchor.constraint(equalToConstant: 80),
            
            
            emailTextField.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            
            // Constraints for the phone number text field - need to update to allow space for the button
            numberTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            numberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            // This needs to be updated so it doesn't stretch to the trailing anchor
            numberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -120),
            
            // Constraints for the phone type button
            phoneTypeButton.leadingAnchor.constraint(equalTo: numberTextField.trailingAnchor, constant: 10),
            phoneTypeButton.centerYAnchor.constraint(equalTo: numberTextField.centerYAnchor),
            phoneTypeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            phoneTypeButton.widthAnchor.constraint(equalToConstant: 100), // You can adjust this as needed
            
            addressTextField.topAnchor.constraint(equalTo: phoneTypeButton.bottomAnchor, constant: 20),
            addressTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            addressTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            addressTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            cityStateTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20),
            cityStateTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            cityStateTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            cityStateTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            zipTextField.topAnchor.constraint(equalTo: cityStateTextField.bottomAnchor, constant: 20),
            zipTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            zipTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            zipTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            saveProfileButton.topAnchor.constraint(equalTo: zipTextField.bottomAnchor, constant: 20),
            saveProfileButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            saveProfileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            saveProfileButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
