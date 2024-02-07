//
//  ViewController.swift
//  WA3_Basswerner_8001
//
//  Created by Paula Basswerner on 2/7/24.
//

import UIKit

class ViewController: UIViewController {

    let landingScreen = LandingScreen()
    
    public struct Package {
        var name:String?
        var email:String?
        
        init(name: String? = nil, email: String? = nil) {
            self.name = name
            self.email = email
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = landingScreen
        
        landingScreen.showProfileButton.addTarget(self, action: #selector(onShowProfileButtonClicked), for: .touchUpInside)
        
    }

    
//    //MARK: submit button tapped action...
//        @objc func onButtonSubmitTapped(){
//            let message = firstScreenView.textFieldMessage.text
//            if let unwrappedMessage = message{
//                //if the message is not empty...
//                if !unwrappedMessage.isEmpty{
//                    // creating a package to send to Display...
//                    let package = Package(message: unwrappedMessage, mood: selectedMood)
//                    
//                    //instantiating displayViewController...
//                    let displayViewController = DisplayViewController()
//                    
//                    //setting the to be sent package...
//                    displayViewController.receivedPackage = package
//                    
//                    //pushing displayController to navigation controller...
//                    navigationController?.pushViewController(displayViewController, animated: true)
//                }else{
//                    //do your thing!
//                }
//            }
//        }
    
    @objc func onShowProfileButtonClicked(){
        let namePackage = landingScreen.nameTextField.text
        if let unwrappedName = namePackage{
            if !unwrappedName.isEmpty{
                
            }
        }
        
    }
    
  

}

