//
//  ArtistController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit
import AVFoundation

class ArtistController: UIViewController {
    var artist: Artist? {
        didSet {
            artistView.artist = artist
        }
    }
    
    var player: AVPlayer?
    
    var songs: [Song] = [] {
        didSet {
            artistView.songs = songs
        }
    }
    
    var artistColor: UIColor? {
        didSet{
            artistView.artistColor = artistColor!
        }
    }
    
    lazy var artistView: ArtistView = {
        let view = ArtistView()
        view.controller = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        view.addSubview(artistView)
        artistView.fillSuperview()
    }
    
    // MARK: - Callback methods
    
    func navigationBackPressed() {
        navigationController?.popViewController(animated: true)
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