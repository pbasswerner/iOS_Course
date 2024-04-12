import UIKit

class MoodLogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    
    @objc func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }

    @objc func moodButtonTapped(_ sender: UIButton) {
        print("Mood selected: \(sender.title(for: .normal) ?? "")")
    }

    @objc func submitTapped() {
        print("Submit tapped")
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
     }

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         // Dismiss the UIImagePickerController if the user cancels
         dismiss(animated: true, completion: nil)
     }
}
