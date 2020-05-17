//
//  Album+CoreDataProperties.swift
//  PinchPhotoAlbum
//
//  Created by Esra Dursun on 19/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//
//

import Foundation
import CoreData


extension Album {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
        return NSFetchRequest<Album>(entityName: "Album")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var title: String?

}
