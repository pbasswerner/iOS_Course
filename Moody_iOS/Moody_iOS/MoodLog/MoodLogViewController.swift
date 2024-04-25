//
//  MoodLogViewController.swift
//  Moody_iOS
//
//  Created by Paula Basswerner on 4/17/24.
//

import UIKit


import UIKit

class MoodLogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MoodSongPlayerDelegate {
    
    
    var moodLogScreen = MoodLogScreen()
    var moodSelected = ""
    var generatedTrack = Track(name: "", id: "", album: Album(name: "", images: []), artists: [] , previewUrl: nil)
    var albumArtUrl = ""

    
    override func loadView() {
        view = moodLogScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        moodLogScreen.pictureImageView.isUserInteractionEnabled = true
        moodLogScreen.pictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImage)))
        moodLogScreen.moodButtons.forEach { button in
            button.addTarget(self, action: #selector(moodButtonTapped(_:)), for: .touchUpInside)
        }
        moodLogScreen.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        moodLogScreen.playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
    }
    
    
    func moodSongPlayerDidSelectSong() {
        self.updateSongDetails()
    }

    
    @objc func moodButtonTapped(_ sender: UIButton) {
        //UI interaction
        print("Mood selected: \(sender.title(for: .normal) ?? "")")
        moodSelected = (sender.title(for: .normal) ?? "")
        // Reset the previous selected button
        if let selectedButton = moodLogScreen.selectedMoodButton {
            selectedButton.backgroundColor = .black
        }
        sender.backgroundColor = .lightGray
        moodLogScreen.selectedMoodButton = sender
        moodLogScreen.isMoodSelected = true  // Mark mood as selected
        
    }
    
    
    @objc func submitTapped() {
        if moodLogScreen.isImageSelected && moodLogScreen.isMoodSelected {
            print("Both mood and image have been selected. Proceeding to navigate...")
            // Get song attributes based on the selected mood
            let (minValence, maxValence, minEnergy, maxEnergy) = attributesForMood(mood: moodSelected)
            
            // Get Song mood
            SpotifyService.shared.fetchSongRecommendationForMood(minValence: minValence, maxValence: maxValence, minEnergy: minEnergy, maxEnergy: maxEnergy) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let tracks):
                        print("Fetched tracks: \(tracks)")
                        // Update the UI with track details
                        if let firstTrack = tracks.first {
                            self.generatedTrack = firstTrack
                            self.navigateToMoodSongPlayer()
                        }
                        
                    case .failure(let error):
                        print("Error fetching recommendations: \(error.localizedDescription)")
                        // Handle error (show alert or error message on the UI)
                    }
                }
            }
        } else {
            print("Please select both a mood and an image.")
            showAlertForIncompleteSelection()
        }
    }
    

    func attributesForMood(mood: String) -> (minValence: Float, maxValence: Float, minEnergy: Float, maxEnergy: Float) {
        switch mood {
        case "Happy":
            return (0.75, 1.0, 0.75, 1.0)  // High valence, medium to high energy
        case "Sad":
            return (0.0, 0.25, 0.0, 0.5)  // Low valence, low to medium energy
        case "Agitated":
            return (0.0, 0.30, 0.75, 1.0)  // Low to Medium valence, high energy
        case "Calm":
            return (0.75, 1.0, 0.1, 0.4)   // Low to medium valence, low energy
        default:
            return (0.25, 0.75, 0.25, 0.75)  // Default range
        }
    }
    
    
    private func showAlertForIncompleteSelection() {
        let alert = UIAlertController(title: "Incomplete Selection", message: "Please select both a mood and an image to proceed.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    // Implement UIImagePickerControllerDelegate methods here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Attempt to retrieve the edited image first, then the original image
        if let editedImage = info[.editedImage] as? UIImage {
            moodLogScreen.pictureImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            moodLogScreen.pictureImageView.image = originalImage
        }
        // Dismiss the UIImagePickerController
        dismiss(animated: true, completion: nil)
        moodLogScreen.isImageSelected = true  // Mark image as selected
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // handle reset if no image is finally selected
        moodLogScreen.isImageSelected = false
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self

        // Create an action sheet to let the user choose between the camera and the photo library
        let alertController = UIAlertController(title: nil, message: "Choose an option", preferredStyle: .actionSheet)
        
        // Add a camera option if it's available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
                guard let self = self else { return }
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        // Add a photo library option
        let libraryAction = UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
            guard let self = self else { return }
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        alertController.addAction(libraryAction)
        
        // Add a cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        // Present the action sheet
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view // or specify another view if needed
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [] // for iPads
        }
        present(alertController, animated: true)
    }

    
    func navigateToMoodSongPlayer() {
        let moodSongPlayerVC = MoodSongPlayerViewController()
        moodSongPlayerVC.delegate = self
        moodSongPlayerVC.generatedTrack = self.generatedTrack
        navigationController?.pushViewController(moodSongPlayerVC, animated: true)
    }
    
    func showAlertForNoTracksFound() {
        let alert = UIAlertController(title: "No Tracks Found", message: "We couldn't find any tracks based on your mood settings. Please try different settings or try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func showAlertForError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "An error occurred while fetching tracks: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    
    func updateSongDetails() {
        
        guard let imageUrl = generatedTrack.album.images.first?.url else {
            print("No image URL available")
            return
        }
        SpotifyService.shared.fetchArtwork(from: imageUrl) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.moodLogScreen.songImageView.image = image
                case .failure(let error):
                    print("Failed to fetch album artwork: \(error.localizedDescription)")
                    self?.moodLogScreen.songImageView.image = UIImage(named: "defaultAlbumCover") // Fallback image
                }
            }
        }
        
        moodLogScreen.songNameLabel.text = generatedTrack.name
        moodLogScreen.artistLabel.text = generatedTrack.artists.first?.name
        
        moodLogScreen.songView.isHidden = false
        moodLogScreen.moodButtonStackView.isHidden = true  // Hide the mood buttons
        moodLogScreen.submitButton.isHidden = true
        moodLogScreen.moodLabelTitle.text = moodSelected
        
    }
    
    @objc private func togglePlayPause() {

        SpotifyService.shared.playOrPauseTrack() // Call the play or pause method

        // Retrieve the current state to update the button icon correctly
        SpotifyService.shared.appRemote.playerAPI?.getPlayerState { [weak self] playerState, error in
            guard let self = self, let playerState = playerState as? SPTAppRemotePlayerState, error == nil else {
                print("Failed to get the current player state: \(error?.localizedDescription ?? "unknown error")")
                return
            }

            let isPlaying = !playerState.isPaused
            let icon = isPlaying ? UIImage(systemName: "pause.fill") : UIImage(systemName: "play.fill")
            DispatchQueue.main.async {
                self.moodLogScreen.playPauseButton.setImage(icon, for: .normal)
            }
        }
    }
    
}

