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
    }
}
