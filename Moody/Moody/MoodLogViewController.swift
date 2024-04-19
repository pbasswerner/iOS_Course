import UIKit

class MoodLogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MoodSongPlayerDelegate {
    
    var moodLogScreen = MoodLogScreen()
    
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
    
    
    func moodSongPlayerDidSelectSong(info: MoodSongInfo) {
        print("Song has been saved: \(info.songName) by \(info.songArtist)")
        updateSongDetails(image: UIImage(named: "songAlbumCover") ?? UIImage(), songName: info.songName, artistName: info.songName)
    }
    
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @objc func moodButtonTapped(_ sender: UIButton) {
        print("Mood selected: \(sender.title(for: .normal) ?? "")")
        moodLogScreen.moodSelected = (sender.title(for: .normal) ?? "")
        // UI -> highlight the button to show it has been pressed
        // functionality get valence and energy level from mood
        
        // Reset the previous selected button
        if let selectedButton = moodLogScreen.selectedMoodButton {
            selectedButton.backgroundColor = .black
        }
        
        sender.backgroundColor = .lightGray
        moodLogScreen.selectedMoodButton = sender
        
        // Print the mood
        print("Mood selected: \(sender.title(for: .normal) ?? "")")
        moodLogScreen.isMoodSelected = true  // Mark mood as selected
        checkSubmitButtonState()
    }
    
    @objc func submitTapped() {
        if moodLogScreen.isImageSelected && moodLogScreen.isMoodSelected {
            print("Both mood and image have been selected. Proceeding to navigate...")
            navigateToMoodSongPlayer()
        } else {
            print("Please select both a mood and an image.")
            showAlertForIncompleteSelection()
        }
    }
    
    private func showAlertForIncompleteSelection() {
        let alert = UIAlertController(title: "Incomplete Selection", message: "Please select both a mood and an image to proceed.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func checkSubmitButtonState() {
        moodLogScreen.submitButton.isEnabled = moodLogScreen.isImageSelected && moodLogScreen.isMoodSelected
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
        checkSubmitButtonState()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // handle reset if no image is finally selected
        moodLogScreen.isImageSelected = false
        dismiss(animated: true, completion: nil)
        checkSubmitButtonState()
    }
    
    func navigateToMoodSongPlayer() {
        let moodSongPlayerVC = MoodSongPlayerViewController()
        moodSongPlayerVC.delegate = self
        navigationController?.pushViewController(moodSongPlayerVC, animated: true)
    }
    
    
       func updateSongDetails(image: UIImage, songName: String, artistName: String) {
           moodLogScreen.songImageView.image = image
           moodLogScreen.songNameLabel.text = songName
           moodLogScreen.artistLabel.text = artistName
           moodLogScreen.songView.isHidden = false
           moodLogScreen.moodButtonStackView.isHidden = true  // Hide the mood buttons
           moodLogScreen.submitButton.isHidden = true
           moodLogScreen.moodLabelTitle.text = moodLogScreen.moodSelected
       }
    
    
}

