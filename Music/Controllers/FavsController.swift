//
//  FavsController.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/15/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import UIKit
import CoreData

class FavsController: UIViewController {
    
    lazy var favsView: FavsView = {
        let view = FavsView()
        view.controller = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFavs()
        
        
        setUpViews()
        
    }
    
    func setUpViews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 234, green: 175, blue: 175).cgColor, UIColor(red: 234, green: 110, blue: 110).cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(favsView)
        favsView.fillSuperview()
    }
    
    func fetchFavs() {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        let predicate = NSPredicate(format: "isFav = \(NSNumber(value:true))")
        
        fetchRequest.predicate = predicate
        
        do {
            
            let results = try context.fetch(fetchRequest) as! [Song]
            favsView.songs = results
            
        } catch let error as NSError {
            print("Could not fetch favs \(error), \(error.userInfo)")
        }
        
    }
    
    // MARK: - Callback methods
    
    func closePressed() {
        dismiss(animated: true, completion: nil)
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
