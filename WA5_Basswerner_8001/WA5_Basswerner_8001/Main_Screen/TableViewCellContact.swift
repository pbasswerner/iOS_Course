//
//  TableViewCellContact.swift
//  WA5_Basswerner_8001
//
//  Created by Paula Basswerner on 2/17/24.
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
        setUpPhoneLabel()
        initConstraints()
    }
    
    func setupWrapperCellView(){
        //        wrapperCellView = UIView()
        //        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        //        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        //        self.addSubview(wrapperCellView)
        
        wrapperCellView = UIView()
        wrapperCellView.layer.borderWidth = 1.0
        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        wrapperCellView.layer.cornerRadius = 8.0
        wrapperCellView.clipsToBounds = true
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }
    
    func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(nameLabel)
    }
    
    func setUpEmailLabel() {
        emailLabel = UILabel()
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(emailLabel)
    }
    
    func setUpPhoneLabel() {
        phoneLabel = UILabel()
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.textAlignment = .center
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(phoneLabel)
        
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
                wrapperCellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
                wrapperCellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
                wrapperCellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),

                nameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
                nameLabel.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
                nameLabel.heightAnchor.constraint(equalToConstant: 20),

                emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                emailLabel.heightAnchor.constraint(equalToConstant: 20),

                phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
                phoneLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
                phoneLabel.heightAnchor.constraint(equalToConstant: 20),
            
            
            
            //In the last constraint of the constraints array, we finally set the height of the wrapperCellView. The wrapperCellView is the container of other UI elements, so we need to set up the height of the container after we set the heights of other elements. We count the height of the container by adding the heights of the UI elements and the margins. (4+20+4+20+4+20+4 = 76).
            wrapperCellView.heightAnchor.constraint(equalToConstant: 92)
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
        
    }
    
}
