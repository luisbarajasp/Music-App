//
//  SongCell.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class SongCell: UICollectionViewCell {
    
    var previewDuration: CGFloat = 0
    
    var previewProgress: CGFloat = 0 {
        didSet {
            progressView.value = previewProgress / previewDuration * 100
        }
    }
    
    var controller: ArtistController!
    
    var isPlaying = false
    
    lazy var playPreviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(self.playPreviewButtonPressed), for: .touchDown)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let progressView: MBCircularProgressBarView = {
        let progress = MBCircularProgressBarView()
        progress.showValueString = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = UIColor(white: 0, alpha: 0)
        progress.progressLineWidth = 1.0
        progress.progressColor = .black
        progress.progressAngle = 100
        progress.progressStrokeColor = .gray
        progress.value = 0
        progress.alpha = 0
        return progress
    }()
    
    var song: Song? {
        didSet{
            if let s = song {
                imageView.loadImageUsingCacheWithURLString(s.imageUrl!, placeHolder: UIImage(named: "art1"))
                nameLabel.text = s.name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0), size: CGSize(width: 60, height: 0))
        
        addSubview(progressView)
        progressView.anchor(top: imageView.topAnchor, leading: nil, bottom: imageView.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 20), size: CGSize(width: 50, height: 0))
        
        addSubview(playPreviewButton)
        playPreviewButton.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        playPreviewButton.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        playPreviewButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        playPreviewButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        
        addSubview(nameLabel)
        nameLabel.anchor(top: imageView.topAnchor, leading: imageView.trailingAnchor, bottom: imageView.bottomAnchor, trailing: progressView.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    @objc
    func playPreviewButtonPressed() {
        if isPlaying {
            playPreviewButton.setImage(UIImage(named: "play"), for: .normal)
            nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
            controller.pause()
            progressView.alpha = 0
        }else{
            progressView.alpha = 1
            playPreviewButton.setImage(UIImage(named: "stop"), for: .normal)
            nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            
            if let url = song?.previewUrl {
                controller.play(urlString: url)
            }
            
        }
        isPlaying = !isPlaying
    }
}
