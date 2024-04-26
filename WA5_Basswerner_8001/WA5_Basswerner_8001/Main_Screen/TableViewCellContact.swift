//
//  TableViewCellContact.swift
//  WA5_Basswerner_8001
//
//  Created by Paula Basswerner on 4/25/24.
//
import UIKit


class TableViewCellContact: UITableViewCell {
    var nameLabel: UILabel!
    var emailLabel: UILabel!
    var phoneLabel: UILabel!
    var profileImageView: UIImageView!
    var wrapperCellView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        setupWrapperCellView()
        setupProfileImageView()
        setUpNameLabel()
        setUpEmailLabel()
        setUpPhoneLabel()
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.layer.borderWidth = 1.0
        wrapperCellView.layer.borderColor = UIColor.gray.cgColor
        wrapperCellView.layer.cornerRadius = 8.0
        wrapperCellView.clipsToBounds = true
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }
    
    func setupProfileImageView() {
        profileImageView = UIImageView()
        // No corner radius for a square image
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(profileImageView)
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
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(phoneLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            profileImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 8),
            profileImageView.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80),

            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 20),

            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.heightAnchor.constraint(equalToConstant: 20),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 92)
        ])
    }
    
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

