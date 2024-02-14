//
//  ViewController.swift
//  WA4_Basswerner_8001
//
//  Created by Paula Basswerner on 2/13/24.
//

import UIKit

class ViewController: UIViewController {
    let mainScreen = MainScreen()
    
    var contacts = [Contact]()
    let phoneTypes = ["Cell", "Home", "Work"]
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Contacts"
        
        mainScreen.tableViewContacts.delegate = self
        mainScreen.tableViewContacts.dataSource = self
        
        mainScreen.tableViewContacts.register(TableViewCellContact.self, forCellReuseIdentifier: "contacts")

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTapped))
        
//        contacts.append(Contact(name: "Paula", phoneNumber: "1234567890", phoneType: "Cell", email: "bass@gmail.com", address: "1234 Elm St", cityState: "Tampa, FL", zip: "33647"))
        
        // Change the back button title to "Back"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        // Adjust the constraints of the back button
        if let backButton = navigationController?.navigationBar.backItem?.backBarButtonItem {
            backButton.title = "Back"
            backButton.customView?.translatesAutoresizingMaskIntoConstraints = false
            backButton.customView?.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
        
        //MARK: recognizing the taps on the app screen, not the keyboard...
          let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
          tapRecognizer.cancelsTouchesInView = false
          view.addGestureRecognizer(tapRecognizer)
        
    }
    
    @objc func onAddButtonTapped() {
        print("Add button tapped")
        let addContactController = AddNewContactViewController()
        addContactController.delegate = self
        navigationController?.pushViewController(addContactController, animated: true)
    }
    
    //MARK: Hide Keyboard...
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    func delegateOnAddContact(contact: Contact) {
        contacts.append(contact)
        mainScreen.tableViewContacts.reloadData()
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! TableViewCellContact
        
        if let unwrappedName = contacts[indexPath.row].name {
            cell.nameLabel.text = unwrappedName
        }
        
        if let unwrappedEmail = contacts[indexPath.row].email {
            cell.emailLabel.text = unwrappedEmail
        }
        
        if let unwrappedPhone = contacts[indexPath.row].phoneNumber {
            if let unwrappedPhoneType = contacts[indexPath.row].phoneType {
                cell.phoneLabel.text = "\(unwrappedPhone) (\(unwrappedPhoneType))"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactDetailController = DetailsViewController()
        contactDetailController.receivedContact = contacts[indexPath.row]
        navigationController?.pushViewController(contactDetailController, animated: true)
    }
    
}

