//
//  ProfileScreen.swift
//  WA3_Basswerner_8001
//
//  Created by Paula Basswerner on 2/7/24.
//

import UIKit

class ProfileScreen: UIView {

    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var addressLabel: UILabel!
    var cityStateLabel: UILabel!
    var zipLabel: UILabel!
    var phoneTypeIcon: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setUpNameLabel()
        setUpEmailLabel()
        setUpPhoneLabel()
        setUpAddressLabel()
        setUpCityStateLabel()
        setUpZipLabel()
        setUpPhoneTypeIcon()
        
        initContraints()
    }
    

    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "Name: "
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Email: "
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailLabel)
    }
    
    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.text = "Phone: "
        phoneLabel.font = UIFont.systemFont(ofSize: 16)
        phoneLabel.textAlignment = .center
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneLabel)
        
    }
    
    func setUpAddressLabel() {
        addressLabel = UILabel()
        addressLabel.text = "Address: "
        addressLabel.font = UIFont.systemFont(ofSize: 16)
        addressLabel.textAlignment = .center
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressLabel)
    }
    
    func setUpCityStateLabel() {
        cityStateLabel = UILabel()
        cityStateLabel.font = UIFont.systemFont(ofSize: 16)
        cityStateLabel.textAlignment = .center
        cityStateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cityStateLabel)
    }
    
    func setUpZipLabel() {
        zipLabel = UILabel()
        zipLabel.text = "Zip: "
        zipLabel.font = UIFont.systemFont(ofSize: 16)
        zipLabel.textAlignment = .center
        zipLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(zipLabel)
    }
    
    func setUpPhoneTypeIcon() {
        phoneTypeIcon = UIImageView()
        phoneTypeIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(phoneTypeIcon)
    }
    
    func initContraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),

            addressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            cityStateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            cityStateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            zipLabel.topAnchor.constraint(equalTo: cityStateLabel.bottomAnchor, constant: 20),
            zipLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            phoneTypeIcon.topAnchor.constraint(equalTo: zipLabel.bottomAnchor, constant: 20),
            phoneTypeIcon.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        

}
                                            
