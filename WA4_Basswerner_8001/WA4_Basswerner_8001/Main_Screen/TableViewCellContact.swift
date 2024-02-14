//
//  TableViewCellContact.swift
//  WA4_Basswerner_8001
//
//  Created by Paula Basswerner on 2/13/24.
//

import UIKit

class TableViewCellContact: UITableViewCell {
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var addressLabel: UILabel!
    var cityStateLabel: UILabel!
    var zipLabel: UILabel!
    var wrapperCellView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        setupWrapperCellView()
        setUpNameLabel()
        setUpEmailLabel()
        //        initContraints()
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.text = "Name: "
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(nameLabel)
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.text = "Email: "
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(emailLabel)
    }
    
    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.text = "Phone: "
        phoneLabel.font = UIFont.systemFont(ofSize: 16)
        phoneLabel.textAlignment = .center
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(phoneLabel)
        
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 4),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 20),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            phoneLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            phoneLabel.heightAnchor.constraint(equalToConstant: 20),
            
            //In the last constraint of the constraints array, we finally set the height of the wrapperCellView. The wrapperCellView is the container of other UI elements, so we need to set up the height of the container after we set the heights of other elements. We count the height of the container by adding the heights of the UI elements and the margins. (4+20+4+20+4+20+4 = 76).
            wrapperCellView.heightAnchor.constraint(equalToConstant: 76)
        ])
    }
    
    
    
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
