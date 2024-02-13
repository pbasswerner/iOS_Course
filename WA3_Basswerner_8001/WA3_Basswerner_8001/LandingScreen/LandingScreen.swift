//
//  LandingScreen.swift
//  WA3_Basswerner_8001
//
//  Created by Paula Basswerner on 2/1/24.
//

import UIKit

class LandingScreen: UIView {
    
    var titleLabel: UILabel!
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var pickerTitleLabel: UILabel!
    var pickerTypeLabel: UILabel!
    var picker: UIPickerView!
    var numberTextField: UITextField!
    var addressTextField: UITextField!
    var cityStateTextField: UITextField!
    var zipTextField: UITextField!
    var showProfileButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setUpTitleLabel()
        setUpNameTextField()
        setUpEmailTextField()
        setUpPickerTitleLabel()
        setUpPickerTypeLabel()
        setUpPicker()
        setUpNumberTextField()
        setUpAddressTextField()
        setUpCityStateTextField()
        setUpZipTextField()
        setUpShowProfileButton()
        
        initContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Create Profile"
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setUpNameTextField() {
        nameTextField = UITextField()
        nameTextField.placeholder = "Name"
        nameTextField.font = UIFont.systemFont(ofSize: 16)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.borderStyle = .roundedRect
        self.addSubview(nameTextField)
    }
    
    func setUpEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.borderStyle = .roundedRect
        self.addSubview(emailTextField)
    }
    
    func setUpPickerTitleLabel() {
        pickerTitleLabel = UILabel()
        pickerTitleLabel.text = "Add Phone"
        pickerTitleLabel.font = UIFont.systemFont(ofSize: 20)
        pickerTitleLabel.textAlignment = .center
        pickerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pickerTitleLabel)
    }
    
    func setUpPickerTypeLabel() {
        pickerTypeLabel = UILabel()
        pickerTypeLabel.text = "Select Type:"
        pickerTypeLabel.font = UIFont.systemFont(ofSize: 16)
        pickerTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pickerTypeLabel)
    }
    
    func setUpPicker() {
        picker = UIPickerView()
        picker.isUserInteractionEnabled = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(picker)
        
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
    
    func setUpShowProfileButton() {
        showProfileButton = UIButton()
        showProfileButton.setTitle("Show Profile", for: .normal)
        showProfileButton.setTitleColor(.blue, for: .normal)
        showProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(showProfileButton)
    }
    
    func initContraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            pickerTitleLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            pickerTitleLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            pickerTypeLabel.topAnchor.constraint(equalTo: pickerTitleLabel.bottomAnchor, constant: 10),
            pickerTypeLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            picker.topAnchor.constraint(equalTo: pickerTypeLabel.bottomAnchor, constant: -20),
            picker.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            numberTextField.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 0),
            numberTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            numberTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            numberTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            addressTextField.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20),
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
            
            showProfileButton.topAnchor.constraint(equalTo: zipTextField.bottomAnchor, constant: 20),
            showProfileButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
    
}
