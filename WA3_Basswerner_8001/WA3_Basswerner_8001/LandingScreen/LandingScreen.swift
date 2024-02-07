//
//  LandingScreen.swift
//  WA3_Basswerner_8001
//
//  Created by Paula Basswerner on 2/1/24.
//

import UIKit

class LandingScreen: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
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
//        setUpPickerTitleLabel()
//        setUpPickerTypeLabel()
//        setUpPicker()
//        setUpNumberTextField()
//        setUpAddressTextField()
//        setUpCityStateTextField()
//        setUpZipTextField()
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
    
    func setUpShowProfileButton() {
        showProfileButton = UIButton()
        showProfileButton.setTitle("Show Profile", for: .normal)
        showProfileButton.setTitleColor(.blue, for: .normal)
        showProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(showProfileButton)
    }
    
    func initContraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            emailTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            showProfileButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            showProfileButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
            
            
        ])
    }
    
}
