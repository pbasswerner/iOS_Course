//
//  ConnecViewController.swift
//  Spotify_Sdk_Integration
//
//  Created by Paula Basswerner on 4/22/24.
//

//


import UIKit

class ConnectLandingViewController: UIViewController {
    
    var connectLandingScreen: ConnectLandingScreen {
        return view as! ConnectLandingScreen
    }
    
    override func loadView() {
        view = ConnectLandingScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpotifyService.shared.connect()
        setupActions()
    }
    
    // Set up the actions for the buttons and other interactive elements.
    private func setupActions() {
        connectLandingScreen.connectButton.addTarget(self, action: #selector(onConnectButtonClicked), for: .touchUpInside)
    }
    
    func loginSpotify() {
        print("Attempting to log in to Spotify...")
        SpotifyService.shared.initiateSession()
    }
 
    
        func navigateToPlayerScreen() {
            print("Navigating to Log Mood screen...")
            
            if let navigationController = navigationController {
                let songPlayerViewController = SongPlayerViewController()
                navigationController.pushViewController(songPlayerViewController, animated: true)
            } else {
                print("Navigation controller not found.")
            }
           
        }
    
    @objc private func onConnectButtonClicked() {
        print("Connect to spotify button clicked")
        loginSpotify()
        navigateToPlayerScreen()
    }
}

