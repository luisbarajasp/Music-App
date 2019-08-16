//
//  SongController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class SongController: UIViewController {
    
    var song: Song? {
        didSet {
            songView.song = song
            if let urlString = song?.previewUrl {
                let url = URL(string: urlString)
                let playerItem = AVPlayerItem(url: url!)
                
                player = AVPlayer(playerItem: playerItem)
                let duration : CMTime = playerItem.asset.duration
                let seconds : Float64 = CMTimeGetSeconds(duration)
                
                self.songView.progressSlider.maximumValue = Float(seconds)
                player?.volume = 1.0
            }
            
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
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 102, green: 214, blue: 115).cgColor, UIColor(red: 165, green: 209, blue: 168).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(songView)
        songView.fillSuperview()
    }
    
    // MARK: - Callback methods
    func setSongFav() {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        let predicate = NSPredicate(format: "id == %@", song!.id!)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do{
            if let song = try context.fetch(request).first as? Song {
                
                song.setValue(!song.isFav, forKey: "isFav")
                
                try context.save()
            }
        }
        catch let error as NSError {
            print("Could not update \(error), \(error.userInfo)")
        }
    }
    
    func closePressed() {
        pause()
        player = nil
        dismiss(animated: true, completion: nil)
    }
    
    func setAudioTime(time: Float) {
//        print(time)
        
        let seconds : Int64 = Int64(time)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            play()
        }
        
    }
    
    // MARK: - Play song
    func play() {
        
        player?.play()
        
        player!.addPeriodicTimeObserver(forInterval: CMTime.init(value: 1, timescale: 1), queue: .main, using: { time in
            if let duration = self.player?.currentItem?.duration {
                let duration = CMTimeGetSeconds(duration), time = CMTimeGetSeconds(time)
                let progress = Float(time/duration)
                if progress >= 0 {
                    
                    self.songView.progressSlider.value = Float(time)
                    
                }
            }
        })
    }
    
    func pause() {
        if let play = player {
            play.pause()
        }
    }
}
