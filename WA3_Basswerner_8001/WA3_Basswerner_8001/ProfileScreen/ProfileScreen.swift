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
//        setUpPhoneLabel()
//        setUpAddressLabel()
//        setUpCityStateLabel()
//        setUpZipLabel()
//        setUpPhoneTypeIcon()
        
        initContraints()
    }
    

    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "Name: "
        nameLabel.font = UIFont.systemFont(ofSize: 24)
        nameLabel.textAlignment = .center
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Email: "
        emailLabel.font = UIFont.systemFont(ofSize: 24)
        emailLabel.textAlignment = .center
    }
    
    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.text = "Phone: "
        phoneLabel.font = UIFont.systemFont(ofSize: 24)
        phoneLabel.textAlignment = .center
    }
    
    func setUpAddressLabel() {
        addressLabel = UILabel()
        addressLabel.text = "Address: "
        addressLabel.font = UIFont.systemFont(ofSize: 24)
        addressLabel.textAlignment = .center
    }
    
    func setUpCityStateLabel() {
        cityStateLabel = UILabel()
        cityStateLabel.font = UIFont.systemFont(ofSize: 24)
        cityStateLabel.textAlignment = .center
    }
    
    func setUpZipLabel() {
        zipLabel = UILabel()
        zipLabel.text = "Zip: "
        zipLabel.font = UIFont.systemFont(ofSize: 24)
        zipLabel.textAlignment = .center
    }
    
    func setUpPhoneTypeIcon() {
        phoneTypeIcon = UIImageView()
    }
    
    func initContraints() {
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        

}
                                            
