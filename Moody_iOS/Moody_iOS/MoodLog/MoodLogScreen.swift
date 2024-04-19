import UIKit

class MoodLogScreen: UIView {
    let dateLabel = UILabel()
    let pictureImageView = UIImageView()
    let moodLabelTitle = UILabel()
    var moodButtons: [UIButton] = []
    let submitButton = UIButton()
    var selectedMoodButton: UIButton?
    var isImageSelected: Bool = false
    var isMoodSelected: Bool = false
    let moodButtonStackView = UIStackView()
   
    
    let songView = UIView()
    let songImageView = UIImageView()
    let songNameLabel = UILabel()
    let artistLabel = UILabel()
    let playPauseButton = UIButton()
    
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
        setupSongView()
    }
    
    private func setupDateLabel() {
        dateLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dateLabel.textAlignment = .left
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dateLabel)
    }
    
    private func setupPictureImageView() {
        let cameraIcon = UIImage(systemName: "camera.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        pictureImageView.image = cameraIcon
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pictureImageView)
    }
    
    private func setupMoodLabelTitle() {
        moodLabelTitle.text = "Choose your Mood"
        moodLabelTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        moodLabelTitle.textAlignment = .left
        moodLabelTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moodLabelTitle)
    }
    
    private func setupMoodButtons() {
        moodButtonStackView.distribution = .fillEqually
        moodButtonStackView.spacing = 10
        moodButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moodButtonStackView)
        
        let moods = ["Joyful", "Calm", "Agitated", "Sad"]
        for mood in moods {
            let button = UIButton()
            button.setTitle(mood, for: .normal)
            button.backgroundColor = .black
            button.layer.cornerRadius = 10
            moodButtonStackView.addArrangedSubview(button)
            moodButtons.append(button)
        }
    }
    
    private func setupSubmitButton() {
        submitButton.setTitle("Get Mood String", for: .normal)
        submitButton.backgroundColor = .black
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(submitButton)
    }
    
    private func setupSongView() {
        songView.isHidden = true  // Initially hidden
        songImageView.image = UIImage(named: "defaultAlbumCover")  // Placeholder image
        songImageView.contentMode = .scaleAspectFit
        
        songNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        artistLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)  // Play icon
        playPauseButton.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        
        songView.addSubview(songImageView)
        songView.addSubview(songNameLabel)
        songView.addSubview(artistLabel)
        songView.addSubview(playPauseButton)
        
        addSubview(songView)
    }
    
    @objc private func togglePlayPause() {
        let isPlaying = playPauseButton.imageView?.image == UIImage(systemName: "pause.fill")
        playPauseButton.setImage(isPlaying ? UIImage(systemName: "play.fill") : UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    
    private func setupConstraints() {
        // Constraints for songView and its subviews
        songView.translatesAutoresizingMaskIntoConstraints = false
        songImageView.translatesAutoresizingMaskIntoConstraints = false
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            pictureImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            pictureImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pictureImageView.widthAnchor.constraint(equalTo: widthAnchor),
            pictureImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3),
            
            moodLabelTitle.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 20),
            moodLabelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            moodButtons[0].superview!.topAnchor.constraint(equalTo: moodLabelTitle.bottomAnchor, constant: 20),
            moodButtons[0].superview!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            moodButtons[0].superview!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            moodButtons[0].superview!.heightAnchor.constraint(equalToConstant: 44),
            
            submitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Song view constraints
            songView.topAnchor.constraint(equalTo: moodLabelTitle.bottomAnchor, constant: 20),
            songView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            songView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            songView.heightAnchor.constraint(equalToConstant: 60),
            
            songImageView.leadingAnchor.constraint(equalTo: songView.leadingAnchor),
            songImageView.widthAnchor.constraint(equalToConstant: 60),
            songImageView.heightAnchor.constraint(equalToConstant: 60),
            
            songNameLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            songNameLabel.topAnchor.constraint(equalTo: songView.topAnchor),
            
            artistLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8),
            artistLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor),
            
            playPauseButton.trailingAnchor.constraint(equalTo: songView.trailingAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: songView.centerYAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 40),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
