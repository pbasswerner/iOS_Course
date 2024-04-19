//
//  MoodSongPlayerScreen.swift
//  Moody_iOS
//
//  Created by Paula Basswerner on 4/18/24.
//

import UIKit

class MoodSongPlayerScreen: UIView {
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let playPauseButton = UIButton()
    let saveMoodSongButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        
        setUpTitleText()
        setUpAlbumImageView()
        setUpPlayPauseButton()
        setupSaveMoodButton()
    }
    
    private func setUpTitleText() {
        titleLabel.text = "Mood Song"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
    }
    
    private func setUpAlbumImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }
    
    private func setUpPlayPauseButton() {
        let playIcon = UIImage(systemName: "play.fill")
        playPauseButton.setImage(playIcon, for: .normal)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playPauseButton)
    }
    
    private func setupSaveMoodButton() {
        saveMoodSongButton.setTitle("Save Mood Song", for: .normal)
        saveMoodSongButton.backgroundColor = .blue
        saveMoodSongButton.setTitleColor(.white, for: .normal)
        saveMoodSongButton.layer.cornerRadius = 10
        saveMoodSongButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(saveMoodSongButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3),
            
            playPauseButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4),
            playPauseButton.heightAnchor.constraint(equalTo: playPauseButton.widthAnchor),  // Make the button square
            
            saveMoodSongButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveMoodSongButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            saveMoodSongButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveMoodSongButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
