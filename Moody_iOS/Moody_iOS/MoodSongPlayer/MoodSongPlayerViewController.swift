
//
//  MoodSongPlayerScreenViewController.swift
//  Moody
//
//  Created by Paula Basswerner on 4/15/24.
//

import UIKit

protocol MoodSongPlayerDelegate: AnyObject {
    func moodSongPlayerDidSelectSong()
}

class MoodSongPlayerViewController: UIViewController {
    
    var generatedTrack: Track?
    
    weak var delegate: MoodSongPlayerDelegate?
    
    var moodSongPlayerScreen: MoodSongPlayerScreen {
        return view as! MoodSongPlayerScreen
    }

    override func loadView() {
        view = MoodSongPlayerScreen()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        moodSongPlayerScreen.playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        moodSongPlayerScreen.saveMoodSongButton.addTarget(self, action: #selector(saveMoodSong), for: .touchUpInside)
        updateAlbumArtwork()
        SpotifyService.shared.playTrack(trackID: generatedTrack?.id ?? "")
        
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
                self.moodSongPlayerScreen.playPauseButton.setImage(icon, for: .normal)
            }
        }
    }

    
    @objc private func saveMoodSong() {
        delegate?.moodSongPlayerDidSelectSong()
        navigationController?.popViewController(animated: true)
    }
    
    func updateAlbumArtwork() {
        guard let imageUrl = generatedTrack?.album.images.first?.url else {
            print("No image URL available")
            return
        }
        
        SpotifyService.shared.fetchArtwork(from: imageUrl) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.moodSongPlayerScreen.imageView.image = image
                case .failure(let error):
                    print("Failed to fetch album artwork: \(error.localizedDescription)")
                    self?.moodSongPlayerScreen.imageView.image = UIImage(named: "defaultAlbumCover") // Fallback image
                }
            }
        }
    }

}





