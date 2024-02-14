//
//  ViewController.swift
//  WA4_Basswerner_8001
//
//  Created by Paula Basswerner on 2/13/24.
//

import UIKit

class ViewController: UIViewController {
    let mainScreen = MainScreen()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(onAddButtonTapped))
    }
    
    @objc func onAddButtonTapped() {
        print("Add button tapped")
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
}

