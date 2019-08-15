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
                          method: .get,
                          parameters: ["include_docs": "true"])
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
    
    private func jsonToArtist(jsonData: [String: AnyObject]) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let artistEntity = NSEntityDescription.insertNewObject(forEntityName: "Artist", into: context) as? Artist,
            jsonData["wrapperType"] as! String == "artist" {
            print(jsonData)
            artistEntity.name = jsonData["artistName"] as? String
            artistEntity.id = String(describing: jsonData["artistId"] as! Int)
            artistEntity.genre = jsonData["primaryGenreName"] as? String
            
            // TODO: photo
            
            return artistEntity
            
        }
        return nil
    }
}
