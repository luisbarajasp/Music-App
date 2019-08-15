//
//  Song+CoreDataProperties.swift
//  Music
//
//  Created by Luis Eduardo Barajas Perez on 8/14/19.
//  Copyright © 2019 Luis Barajas. All rights reserved.
//
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var previewUrl: String?
    @NSManaged public var url: String?
    @NSManaged public var artist: Artist?

}
