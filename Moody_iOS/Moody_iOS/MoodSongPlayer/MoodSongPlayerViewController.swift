
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
    
//    func updateAlbumArtwork() {
//        guard let trackID = generatedTrack?.id else {
//            print("Track ID is unavailable")
//            return
//        }
//
//        SpotifyService.shared.fetchAlbumArtwork(trackID: trackID) { [weak self] image in
//            DispatchQueue.main.async {
//                guard let self = self else { return }
//                if let image = image {
//                    self.moodSongPlayerScreen.imageView.image = image
//                } else {
//                    self.moodSongPlayerScreen.imageView.image = UIImage(named: "defaultAlbumCover") // Fallback image
//                }
//            }
//        }
//    }

}





