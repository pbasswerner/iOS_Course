import UIKit

protocol SongPlayerDelegate: AnyObject {
    func moodSongPlayerDidSelectSong()
}

class SongPlayerViewController: UIViewController {
    
    var generatedTrackId = "7sq2z9oX2S0CvgTqCZ0ko4"
    var generatedTrack: Track?
    
    var songPlayerScreen: SongPlayerScreen {
        return view as! SongPlayerScreen
    }

    override func loadView() {
        view = SongPlayerScreen()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        songPlayerScreen.playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        fetchTrackDetails()
        SpotifyService.shared.playTrack(trackID: generatedTrackId)
    }

    func fetchTrackDetails() {
        
        SpotifyService.shared.fetchTrackById(trackId: generatedTrackId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let track):
                    self?.generatedTrack = track
                    self?.updateUIWithTrackDetails(track)
                case .failure(let error):
                    print("Error fetching track: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateUIWithTrackDetails(_ track: Track) {
        updateAlbumArtwork()  // Update the album artwork now that you have the track details
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
                self.songPlayerScreen.playPauseButton.setImage(icon, for: .normal)
            }
        }
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
                    self?.songPlayerScreen.imageView.image = image
                case .failure(let error):
                    print("Failed to fetch album artwork: \(error.localizedDescription)")
                    self?.songPlayerScreen.imageView.image = UIImage(named: "defaultAlbumCover") // Fallback image
                }
            }
        }
    }
}
