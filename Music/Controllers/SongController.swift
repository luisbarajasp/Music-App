//
//  SongController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit
import AVFoundation

class SongController: UIViewController {
    
    var song: Song? {
        didSet {
            songView.song = song
        }
    }
    
    var player: AVPlayer?
    
    lazy var songView: SongView = {
        let song = SongView()
        song.controller = self
        return song
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        view.addSubview(songView)
        songView.fillSuperview()
    }
    
    // MARK: - Callback methods
    func setFav() {
    }
    
    // MARK: - Play song
    func play(urlString: String) {
        print(urlString)
        
        let url = URL(string: urlString)
        let playerItem = AVPlayerItem(url: url!)
        
        player = AVPlayer(playerItem: playerItem)
        player?.volume = 1.0
        player?.play()
    }
    
    func pause() {
        if let play = player {
            play.pause()
        }
        player = nil
        
    }
}
