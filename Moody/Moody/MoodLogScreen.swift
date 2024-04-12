//
//  MoodLogScreen.swift
//  Moody
//
//  Created by Paula Basswerner on 4/12/24.
//


import UIKit

class MoodLogScreen: UIView {
    let dateLabel = UILabel()
    let pictureImageView = UIImageView()
    let moodLabelTitle = UILabel()
    var moodButtons: [UIButton] = []
    let submitButton = UIButton()

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
        
        setupDateLabel()
        setupPictureImageView()
        setupMoodLabelTitle()
        setupMoodButtons()
        setupSubmitButton()
    }
    
    private func setupDateLabel() {
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateLabel)
    }

    private func setupPictureImageView() {
        pictureImageView.image = UIImage(systemName: "camera.fill")
        pictureImageView.contentMode = .scaleAspectFill
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pictureImageView)
    }

    private func setupMoodLabelTitle() {
        moodLabelTitle.text = "Choose your Mood"
        moodLabelTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        moodLabelTitle.textAlignment = .center
        moodLabelTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moodLabelTitle)
    }

    private func setupMoodButtons() {
        let moods = ["Happy", "Sad", "Angry", "Excited"]
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        for mood in moods {
            let button = UIButton()
            button.setTitle(mood, for: .normal)
            button.backgroundColor = .gray
            button.layer.cornerRadius = 10
            moodButtons.append(button)
            stackView.addArrangedSubview(button)
        }
    }

    private func setupSubmitButton() {
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .black
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(submitButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            pictureImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            pictureImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pictureImageView.widthAnchor.constraint(equalToConstant: 100),
            pictureImageView.heightAnchor.constraint(equalToConstant: 100),
            
            moodLabelTitle.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 20),
            moodLabelTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            moodButtons[0].superview!.topAnchor.constraint(equalTo: moodLabelTitle.bottomAnchor, constant: 20),
            moodButtons[0].superview!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            moodButtons[0].superview!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            moodButtons[0].superview!.heightAnchor.constraint(equalToConstant: 44),
            
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

