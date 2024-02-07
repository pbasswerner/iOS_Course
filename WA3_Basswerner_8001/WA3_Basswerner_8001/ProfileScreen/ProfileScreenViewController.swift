//
//  ProfileScreenViewController.swift
//  WA3_Basswerner_8001
//
//  Created by Paula Basswerner on 2/7/24.
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
    }
    

}
