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
            
        }
    }
    
    var previewDuration: CGFloat = 0
    
    var previewProgress: CGFloat = 0 {
        didSet {
            progressView.value = previewProgress / previewDuration * 100
        }
    }
    
    var controller: SongController!
    
    var isPlaying = false
    
    lazy var playPreviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(self.playPreviewButtonPressed), for: .touchDown)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        addSubview(progressView)
        progressView.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 20), size: CGSize(width: 50, height: 0))
        
        addSubview(playPreviewButton)
        playPreviewButton.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        playPreviewButton.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        playPreviewButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        playPreviewButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    @objc
    func playPreviewButtonPressed() {
        if isPlaying {
            playPreviewButton.setImage(UIImage(named: "play"), for: .normal)
            controller.pause()
            progressView.alpha = 0
        }else{
            progressView.alpha = 1
            playPreviewButton.setImage(UIImage(named: "stop"), for: .normal)
            
            if let url = song?.previewUrl {
                controller.play(urlString: url)
            }
            
        }
        isPlaying = !isPlaying
    }
}
