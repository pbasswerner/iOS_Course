//
//  DetailsViewController.swift
//  WA5_Basswerner_8001
//
//  Created by Paula Basswerner on 2/14/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let detailsScreen = DetailsScreen()
    var receivedContact: Contact = Contact()
    
    override func loadView() {
        view = detailsScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        if let unwrappedName = receivedContact.name{
            if !unwrappedName.isEmpty{
                detailsScreen.nameLabel.text = "\(unwrappedName)"
            }
        }
        
        if let unwrappedEmail = receivedContact.email{
            if !unwrappedEmail.isEmpty{
                detailsScreen.emailLabel.text = "Email: \(unwrappedEmail)"
            }
        }
        
        
        if let unwrappedPhoneNumber = receivedContact.phoneNumber{
            if !unwrappedPhoneNumber.isEmpty{
                if let unwrappedPhoneType = receivedContact.phoneType{
                    if !unwrappedPhoneType.isEmpty{
                        detailsScreen.phoneLabel.text = "Phone: \(unwrappedPhoneNumber) (\(unwrappedPhoneType))"
                    }
                }
            }
        }
        
        
        if let unwrappedAddress = receivedContact.address{
            if !unwrappedAddress.isEmpty{
                detailsScreen.addressLabel.text = "\(unwrappedAddress)"
            }
        }
        
        if let unwrappedCityState = receivedContact.cityState{
            if !unwrappedCityState.isEmpty{
                detailsScreen.cityStateLabel.text = "\(unwrappedCityState)"
            }
        }
        
        if let unwrappedZip = receivedContact.zip{
            if !unwrappedZip.isEmpty{
                detailsScreen.zipLabel.text = "\(unwrappedZip)"
            }
        }
    }
    
}
