//
//  ArtistController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit
import CoreData

class ArtistController: UIViewController {
    var artist: Artist? {
        didSet {
            artistView.artist = artist
        }
    }
    
    var songs: [Song] = [] {
        didSet {
            artistView.songs = songs
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
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 197, green: 203, blue: 216).cgColor, UIColor(red: 120, green: 150, blue: 211).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(artistView)
        artistView.fillSuperview()
    }
    
    // MARK: - Callback methods
    
    func navigationBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func navigateToSong(song: Song) {
        let songController = SongController()
        songController.song = song
        
        present(songController, animated: true, completion: nil)
    }
    
    func setSongFav(id: String, fav: Bool) {
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do{
            if let song = try context.fetch(request).first as? Song {
                
                song.setValue(fav, forKey: "isFav")
                
                try context.save()
            }
        }
        catch let error as NSError {
            print("Could not update \(error), \(error.userInfo)")
        }
    }
}
