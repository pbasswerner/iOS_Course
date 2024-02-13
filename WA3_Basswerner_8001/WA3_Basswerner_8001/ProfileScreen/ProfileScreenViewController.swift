//
//  ProfileScreenViewController.swift
//  WA3_Basswerner_8001
//
//  Created by Paula Basswerner on 2/6/24.
//

import UIKit

class ProfileScreenViewController: UIViewController {
    
    let profileScreen = ProfileScreen()
    
    var receivedPackage: ViewController.Package = ViewController.Package()
    
    override func loadView() {
        view = profileScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let unwrappedName = receivedPackage.name{
            if !unwrappedName.isEmpty{
                profileScreen.nameLabel.text = "Name: \(unwrappedName)"
            }
        }
        
        if let unwrappedEmail = receivedPackage.email{
            if !unwrappedEmail.isEmpty{
                profileScreen.emailLabel.text = "Email: \(unwrappedEmail)"
            }
        }
        
        if let unwrappedPhoneType = receivedPackage.phoneType{
            if !unwrappedPhoneType.isEmpty{
                profileScreen.phoneTypeIcon.image = UIImage(named: unwrappedPhoneType.lowercased())
            }
        }
        
        if let unwrappedPhoneNumber = receivedPackage.phoneNumber{
            if !unwrappedPhoneNumber.isEmpty{
                profileScreen.phoneLabel.text = "Phone: \(unwrappedPhoneNumber) (\(receivedPackage.phoneType ?? ""))"
            }
        }
        
      
        if let unwrappedAddress = receivedPackage.address{
            if !unwrappedAddress.isEmpty{
                profileScreen.addressLabel.text = "Address: \(unwrappedAddress)"
            }
        }
        
        if let unwrappedCityState = receivedPackage.cityState{
            if !unwrappedCityState.isEmpty{
                profileScreen.cityStateLabel.text = "\(unwrappedCityState)"
            }
        }
        
        if let unwrappedZip = receivedPackage.zip{
            if !unwrappedZip.isEmpty{
                profileScreen.zipLabel.text = "Zip: \(unwrappedZip)"
            }
        }
    }
    

}
