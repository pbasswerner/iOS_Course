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
        
        contacts.append(Contact(name: "Paula Basswerner", phoneNumber: "555-555-5555", phoneType: "Cell", email: "basswerner.p@gmail.com", address: "1234 Main St", cityStateZip: "Anytown, USA 12345", zipcode: "12345"))
        
        contacts.append(Contact(name: "Paula b", phoneNumber: "555-555-5555", phoneType: "Cell", email: "basswerner.p@gmail.com", address: "1234 Main St", cityStateZip: "Anytown, USA 12345", zipcode: "12345"))
        
        contacts.append(Contact(name: "Paula Basswerner", phoneNumber: "555-555-5555", phoneType: "Cell", email: "basswerner.p@gmail.com", address: "1234 Main St", cityStateZip: "Anytown, USA 12345", zipcode: "12345"))
        
    }
    
    @objc func onAddButtonTapped() {
        print("Add button tapped")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contacts", for: indexPath) as! TableViewCellContact
        
        cell.nameLabel.text = contacts[indexPath.row].name
        
        cell.emailLabel.text = contacts[indexPath.row].email
        
        cell.phoneLabel.text = "857 294 2638"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.contacts[indexPath.row])
    }
    
}

