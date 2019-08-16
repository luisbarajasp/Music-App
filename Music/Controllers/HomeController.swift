//
//  ViewController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController {
    
    lazy var homeView: HomeView = {
        let view = HomeView()
        view.controller = self
        return view
    }()
    
    lazy var favsButton: FavsButton = {
        let b = FavsButton()
        b.controller = self
        return b
    }()
    
    let service = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        clearSongs()
//        clearArtists()
        
        setUpViews()
        fetchArtists()
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(homeView)
        homeView.fillSuperview()
        
        view.addSubview(favsButton)
        favsButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10), size: CGSize(width: 70, height: 70))
        
    }
    
    override func viewDidLayoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 250, green: 189, blue: 75).cgColor, UIColor(red: 252, green: 231, blue: 148).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = homeView.bounds
        
        homeView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Fetch Artists
    
    func fetchArtists(with term: String = "ma") {
        service.fetchArtists(with: "search?media=music&entity=musicArtist&limit=20&term=\(term)", completion: { (artists) in
            if artists != nil {
//                print(artists)
                self.homeView.artists = artists!
            }
        })
    }
    
    // MARK: - Alert
    
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Callback methods
    func navigateToSearch(searchQuery: String?) {
        if let query = searchQuery, query != "" {
            let searchController = SearchController()
            searchController.query = query
            
            service.fetchArtists(with: "search?media=music&entity=musicArtist&limit=20&term=\(query)", completion: { (artists) in
                if artists != nil, artists!.count > 0 {
                    searchController.artists = artists!
                    self.navigationController?.pushViewController(searchController, animated: true)
                } else {
                    self.showAlertWith(title: "No results", message: "No artists were found with that name, try another.")
                }
            })
            
        }
    }
    
    func navigateToArtist(artist: Artist?) {
        if let a = artist {
            let artistController = ArtistController()
            artistController.artist = a
            
            service.fetchSongs(addTo: a, with: "lookup?id=\(a.id!)&entity=song&limit=20", completion: { (songs) in
                if songs != nil {
                    artistController.songs = songs!
                    self.navigationController?.pushViewController(artistController, animated: true)
                }
            })
        }
    }
    
    func presentFavsController() {
        present(FavsController(), animated: true, completion: nil)
    }

    // MARK: - clearData from CoreData for debugging
    private func clearArtists() {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Artist")
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    private func clearSongs() {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}

