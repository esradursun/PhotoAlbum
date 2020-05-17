//
//  CoreDataManagerProtocol.swift
//  PinchPhotoAlbum
//
//  Created by Esra Dursun on 22/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation

protocol CoreDataManagerProtocol {
    var persistentContainer: NSPersistentContainer! {get}
    var managedObjectContext: NSManagedObjectContext! {get}
    func saveContext()
}
