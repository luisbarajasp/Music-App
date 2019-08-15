//
//  SongCell.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit

class SongCell: UICollectionViewCell {
    
    var controller: ArtistController!
    
    var isPlaying = false
    
    lazy var playPreviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(self.playPreviewButtonPressed), for: .touchDown)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.sizeToFit()
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
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
        imageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0), size: CGSize(width: 0, height: 60))
        
        addSubview(playPreviewButton)
        playPreviewButton.anchor(top: imageView.topAnchor, leading: nil, bottom: imageView.bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20), size: CGSize(width: 40, height: 0))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: imageView.topAnchor, leading: imageView.trailingAnchor, bottom: imageView.bottomAnchor, trailing: playPreviewButton.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    }
    
    @objc
    func playPreviewButtonPressed() {
        if isPlaying {
            playPreviewButton.setImage(UIImage(named: "play"), for: .normal)
            nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
            controller.pause()
        }else{
            playPreviewButton.setImage(UIImage(named: "stop"), for: .normal)
            nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            
            if let url = song?.previewUrl {
                controller.play(urlString: url)
            }
        }
        isPlaying = !isPlaying
    }
}
