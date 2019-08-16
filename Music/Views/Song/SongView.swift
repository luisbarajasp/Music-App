//
//  File.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class SongView: UIView {
    
    var song: Song? {
        didSet{
            if let s = song {
                imageView.loadImageUsingCacheWithURLString(s.imageUrl!, placeHolder: UIImage(named: "art1"))
                nameLabel.text = s.name
                
                var origImage: UIImage!
                
                if song!.isFav {
                    origImage = UIImage(named: "heart-filled")
                }else{
                    origImage = UIImage(named: "heart")
                }
                
                let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
                favButton.setImage(tintedImage, for: .normal)
            }
        }
    }
    
    var duration: CGFloat = 0
    
    var progress: CGFloat = 0 {
        didSet {
            //            progressView.value = progress / duration * 100
        }
    }
    
    var controller: SongController!
    
    var isPlaying = false
    
    lazy var closeButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(self.closeButtonPressed), for: .touchDown)
        b.setImage(UIImage(named: "close"), for: .normal)
        b.imageView?.contentMode = .scaleAspectFit
        return b
    }()
    
    lazy var favButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.favButtonPressed), for: .touchDown)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        let origImage = UIImage(named: "heart")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .red
        return button
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 75
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        return iv
    }()
    
    let imageContainerView = UIView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    lazy var progressSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.isContinuous = true
        slider.setValue(0, animated: false)
        slider.addTarget(self, action: #selector(self.changeVlaue(_:)), for: .valueChanged)
        slider.minimumTrackTintColor = .black
        slider.maximumTrackTintColor = UIColor(white: 0, alpha: 0.1)
        
        slider.thumbTintColor = .black
        return slider
    }()
    
    lazy var rewindButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "rewind"), for: .normal)
        button.addTarget(self, action: #selector(self.rewindButtonPressed), for: .touchDown)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(self.playButtonPressed), for: .touchDown)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var fastForwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "fast-forward"), for: .normal)
        button.addTarget(self, action: #selector(self.fastForwardButtonPressed), for: .touchDown)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
        backgroundColor = .transparent
        
        addSubview(closeButton)
        closeButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 0), size: CGSize(width: 30, height: 50))
        
        addSubview(favButton)
        favButton.anchor(top: closeButton.topAnchor, leading: nil, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20), size: CGSize(width: 30, height: 50))
        
        addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        playButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        
        addSubview(rewindButton)
        rewindButton.anchorSize(to: playButton)
        rewindButton.anchor(top: playButton.topAnchor, leading: nil, bottom: playButton.bottomAnchor, trailing: playButton.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30))
        
        addSubview(fastForwardButton)
        fastForwardButton.anchorSize(to: playButton)
        fastForwardButton.anchor(top: playButton.topAnchor, leading: playButton.trailingAnchor, bottom: playButton.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0))
        
        addSubview(progressSlider)
        progressSlider.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: playButton.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 30, bottom: 50, right: 30), size: CGSize(width: 0, height: 30))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: progressSlider.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 30, bottom: 50, right: 30))
        
        
        addSubview(imageContainerView)
        imageContainerView.anchor(top: closeButton.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nameLabel.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        
        imageContainerView.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    func restart() {
        progressSlider.value = 0
        isPlaying = false
        playButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    @objc
    func favButtonPressed() {
        
        if song!.isFav {
            let origImage = UIImage(named: "heart")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            favButton.setImage(tintedImage, for: .normal)
        }else {
            let origImage = UIImage(named: "heart-filled")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            favButton.setImage(tintedImage, for: .normal)
        }
        
        controller.setSongFav()
        
    }
    
    @objc
    func playButtonPressed() {
        if isPlaying {
            playButton.setImage(UIImage(named: "play"), for: .normal)
            controller.pause()
        }else{
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            
            controller.setAudioTime(time: progressSlider.value)
            
        }
        isPlaying = !isPlaying
    }
    
    @objc
    func rewindButtonPressed() {
        controller.setAudioTime(time: progressSlider.value - 2.0)
        playButton.setImage(UIImage(named: "pause"), for: .normal)
        isPlaying = true
    }
    
    @objc
    func fastForwardButtonPressed() {
        controller.setAudioTime(time: progressSlider.value + 2.0)
        playButton.setImage(UIImage(named: "pause"), for: .normal)
        isPlaying = true
    }
    
    @objc
    func closeButtonPressed() {
        controller.closePressed()
    }
    
    @objc
    func changeVlaue(_ sender: UISlider) {
        controller.setAudioTime(time: sender.value)
    }
}
