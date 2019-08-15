//
//  API.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class APIService: NSObject {
    lazy var endPoint: String = {
        return "https://itunes.apple.com/"
    }()
    
    // fetch Artists
    func fetchArtists(with params: String = "", completion: @escaping ([Artist]?) -> Void) {
        guard let url = URL(string: self.endPoint + params) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote artists: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject],
                    let results = value["results"] as? [[String: AnyObject]] else {
                        print("Malformed data received from fetchArtists service")
                        completion(nil)
                        return
                }
                
                var artists: [Artist] = []
                
                for artJson in results {
                    if let artist = self.jsonToArtist(jsonData: artJson) as? Artist {
                        artists.append(artist)
                    }
                }
                
                do {
                    try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
                } catch let error {
                    print(error)
                }
                
                completion(artists)
        }
    }
    
    // fetch songs
    func fetchSongs(addTo artist: Artist, with params: String = "", completion: @escaping ([Song]?) -> Void) {
        guard let url = URL(string: self.endPoint + params) else {
            completion(nil)
            return
        }
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote artists: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject],
                    let results = value["results"] as? [[String: AnyObject]] else {
                        print("Malformed data received from fetchArtists service")
                        completion(nil)
                        return
                }
                
                var songs: [Song] = []
                
                for songJson in results {
                    if let song = self.jsonToSong(jsonData: songJson) as? Song {
                        artist.addToSongs(song)
                        songs.append(song)
                    }
                }
                
                do {
                    try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
                } catch let error {
                    print(error)
                }
                
                completion(songs)
        }
    }
    
    private func jsonToArtist(jsonData: [String: AnyObject]) -> NSManagedObject? {
        guard jsonData["wrapperType"] as! String == "artist" else {
            return nil
        }
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let id = String(describing: jsonData["artistId"] as! Int)
        // Check if artist already exist
        
        if let artist = artistExists(context: context, id: id) {
            return artist
        } else {
            // it doesn't exist, save it in CoreData
            if let artistEntity = NSEntityDescription.insertNewObject(forEntityName: "Artist", into: context) as? Artist {
                artistEntity.name = jsonData["artistName"] as? String
                artistEntity.id = id
                artistEntity.genre = jsonData["primaryGenreName"] as? String
                
                // Search for photo of first song to display
                fetchSongs(addTo: artistEntity, with: "lookup?id=\(id)&entity=song&limit=1", completion: { (songs) in
                    if songs != nil, songs!.count > 0 {
                        print(songs)
                        
                    }
                })
                
                return artistEntity
                
            }
            return nil
        }
        
    }
    
    private func jsonToSong(jsonData: [String: AnyObject]) -> NSManagedObject? {
        guard jsonData["wrapperType"] as! String == "track" else {
            return nil
        }
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let id = String(describing: jsonData["trackId"] as! Int)
        // Check if artist already exist
        
        if let song = songExists(context: context, id: id) {
            return song
        } else {
            // it doesn't exist, save it in CoreData
            if let songEntity = NSEntityDescription.insertNewObject(forEntityName: "Song", into: context) as? Song {
                songEntity.name = jsonData["trackCensoredName"] as? String
                songEntity.id = id
                songEntity.previewUrl = jsonData["previewUrl"] as? String
                songEntity.imageUrl = jsonData["artworkUrl100"] as? String
                songEntity.collectionName = jsonData["collectionCensoredName"] as? String
                
                return songEntity
                
            }
            return nil
        }
        
    }
    
    // Check if artist already exist
    private func artistExists(context: NSManagedObjectContext, id: String) -> Artist? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Artist")
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do{
            if let artist = try context.fetch(request).first as? Artist {
                return artist
            }else{
                return nil
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return nil
    }
    
    // Check if song already exist
    private func songExists(context: NSManagedObjectContext, id: String) -> Song? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Song")
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do{
            if let song = try context.fetch(request).first as? Song {
                return song
            }else{
                return nil
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return nil
    }
    
}
