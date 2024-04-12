//
//  ConnectLandingViewController.swift
//  Moody
//
//  Created by Paula Basswerner on 4/12/24.
//


import UIKit

class ConnectLandingViewController: UIViewController {
    // The main view for this controller, cast to the custom view type.
    var connectLandingScreen: ConnectLandingScreen {
        return view as! ConnectLandingScreen
    }

    override func loadView() {
        view = ConnectLandingScreen()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    // Set up the actions for the buttons and other interactive elements.
    private func setupActions() {
        connectLandingScreen.connectButton.addTarget(self, action: #selector(onConnectButtonClicked), for: .touchUpInside)
    }

    // MARK: - Actions


    // MARK: - Spotify Integration Methods

    func loginSpotify() {
        // Code to initiate Spotify login flow.
        print("Attempting to log in to Spotify...")
        // After login, you might want to fetch tracks or navigate directly.
        getLatestTracks()
    }

    func getLatestTracks() {
        // Code to fetch the latest tracks from Spotify.
        print("Fetching the latest tracks from Spotify...")
    }
    
    func navigateToLogMood() {
        print("Navigating to Log Mood screen...")
        let moodLogViewController = MoodLogViewController() // Assuming you have this view controller defined
        navigationController?.pushViewController(moodLogViewController, animated: true)
    }
    
    @objc private func onConnectButtonClicked() {
        print("Attempting to navigate...")
        if let navigationController = navigationController {
            let moodLogViewController = MoodLogViewController()
            navigationController.pushViewController(moodLogViewController, animated: true)
        } else {
            print("Navigation controller not found.")
        }
    }
}
