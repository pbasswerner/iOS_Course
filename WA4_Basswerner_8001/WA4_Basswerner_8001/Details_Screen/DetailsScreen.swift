//
//  DetailsScreen.swift
//  WA4_Basswerner_8001
//
//  Created by Paula Basswerner on 2/14/24.
//

import UIKit

class DetailsScreen: UIView {

    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var addressTitleLabel: UILabel!
    var addressLabel: UILabel!
    var cityStateLabel: UILabel!
    var zipLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setUpNameLabel()
        setUpEmailLabel()
        setUpPhoneLabel()
        setUpAddressTitleLabel()
        setUpAddressLabel()
        setUpCityStateLabel()
        setUpZipLabel()
        
        initContraints()
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
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
    
    func setUpAddressTitleLabel() {
        addressTitleLabel = UILabel()
        addressTitleLabel.text = "Address"
        addressTitleLabel.textAlignment = .center
        addressTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        addressTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addressTitleLabel)
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
    
    func initContraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            addressTitleLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20),
            addressTitleLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            addressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 5),
            addressLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            cityStateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5),
            cityStateLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),

            zipLabel.topAnchor.constraint(equalTo: cityStateLabel.bottomAnchor, constant: 5),
            zipLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
