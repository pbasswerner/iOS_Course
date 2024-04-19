//
//  MoodSongPlayerScreenViewController.swift
//  Moody
//
//  Created by Paula Basswerner on 4/15/24.
//

import UIKit

protocol MoodSongPlayerDelegate: AnyObject {
    func moodSongPlayerDidSelectSong(info: MoodSongInfo)
}

class MoodSongPlayerViewController: UIViewController {
    
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
    }
    
    @objc private func togglePlayPause() {
        let isPlaying = moodSongPlayerScreen.playPauseButton.imageView?.image == UIImage(systemName: "pause.fill")
        let icon = isPlaying ? UIImage(systemName: "play.fill") : UIImage(systemName: "pause.fill")
        moodSongPlayerScreen.playPauseButton.setImage(icon, for: .normal)
    }
    
    @objc private func saveMoodSong() {
        let songInfo = MoodSongInfo(songURI: "Some song URI", songName: "Name", songArtist: "Artist")
        delegate?.moodSongPlayerDidSelectSong(info: songInfo)
        navigationController?.popViewController(animated: true)
    }

}
