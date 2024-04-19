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
    }
    
    
    func moodSongPlayerDidSelectSong() {
        self.updateSongDetails(image: UIImage(), songName: generatedTrack.name, artistName: generatedTrack.artists.first?.name ?? "Unknown Artist")
    }
    
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
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
    
//    @objc func submitTapped() {
//        if moodLogScreen.isImageSelected && moodLogScreen.isMoodSelected {
//            print("Both mood and image have been selected. Proceeding to navigate...")
//            let (minValence, maxValence, minEnergy, maxEnergy) = attributesForMood(mood: moodSelected)
//            
//            SpotifyService.shared.fetchSongRecommendationForMood(minValence: minValence, maxValence: maxValence, minEnergy: minEnergy, maxEnergy: maxEnergy) { result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success(let tracks):
//                        if let firstTrack = tracks.first {
//                            self.generatedTrack = firstTrack
//                            self.updateSongDetailsForSelectedTrack(track: firstTrack)
//                            self.navigateToMoodSongPlayer()
//                        } else {
//                            print("No tracks found for the specified mood settings.")
//                            self.showAlertForNoTracksFound()
//                        }
//                    case .failure(let error):
//                        print("Error fetching recommendations: \(error.localizedDescription)")
//                        self.showAlertForError(error: error)
//                    }
//                }
//            }
//        } else {
//            print("Please select both a mood and an image.")
//            showAlertForIncompleteSelection()
//        }
//    }
    

    
    
    
    func attributesForMood(mood: String) -> (minValence: Float, maxValence: Float, minEnergy: Float, maxEnergy: Float) {
        switch mood {
        case "Happy":
            return (0.75, 1.0, 0.5, 1.0)  // High valence, medium to high energy
        case "Sad":
            return (0.0, 0.25, 0.0, 0.5)  // Low valence, low to medium energy
        case "Agitated":
            return (0.1, 0.50, 0.75, 1.0)  // Low to Medium valence, high energy
        case "Calm":
            return (0.4, 0.8, 0.0, 0.4)   // Low to medium valence, low energy
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

    
    
    func updateSongDetails(image: UIImage, songName: String, artistName: String) {
        moodLogScreen.songImageView.image = image
        moodLogScreen.songNameLabel.text = songName
        moodLogScreen.artistLabel.text = artistName
        
        moodLogScreen.songView.isHidden = false
        moodLogScreen.moodButtonStackView.isHidden = true  // Hide the mood buttons
        moodLogScreen.submitButton.isHidden = true
        moodLogScreen.moodLabelTitle.text = moodSelected
        
    }
    
}

