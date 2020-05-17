//
//  Photo+CoreDataProperties.swift
//  PinchPhotoAlbum
//
//  Created by Esra Dursun on 19/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var albumId: Int16
    @NSManaged public var url: String?
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var thumbnailUrl: String?

}
