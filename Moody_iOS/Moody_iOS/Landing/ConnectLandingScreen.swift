//
//  ConnectLandingScreen.swift
//  Moody
//
//  Created by Paula Basswerner on 4/12/24.
//

import UIKit

class ConnectLandingScreen: UIView {
    var spotifyLogo: UIImageView!
    var connectButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        setUpLogo()
        setUpConnectButton()
    }
    
    private func setUpLogo(){
        // Setup the Spotify logo
        spotifyLogo = UIImageView()
        spotifyLogo.contentMode = .scaleAspectFit
        spotifyLogo.translatesAutoresizingMaskIntoConstraints = false
        spotifyLogo.image = UIImage(named: "spotifyLogo")
        addSubview(spotifyLogo)
    }
    
    private func setUpConnectButton(){
        // Setup the connect button
        connectButton = UIButton(type: .system)
        connectButton.setTitle("Connect to Spotify", for: .normal)
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(connectButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Spotify Logo constraints
            spotifyLogo.centerXAnchor.constraint(equalTo: centerXAnchor),
            spotifyLogo.centerYAnchor.constraint(equalTo: centerYAnchor),
            spotifyLogo.widthAnchor.constraint(equalToConstant: 150),
            spotifyLogo.heightAnchor.constraint(equalToConstant: 150),

            // Connect button constraints
            connectButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            connectButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            connectButton.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            connectButton.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20)
        ])
    }
}

