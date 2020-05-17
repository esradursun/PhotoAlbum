//
//  CoreDataManagerMock.swift
//  PhotoAlbumTests
//
//  Created by Esra Dursun on 22/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
import XCTest
import CoreData
@testable import PhotoAlbum

class CoreDataManagerMock: CoreDataManager {
    
    let albumList : [AlbumModel] = [
        AlbumModel(id: 1, userId: 1, title: "quidem molestiae enim"),
        AlbumModel(id: 2, userId: 2, title: "quidem molestiae enim"),
        AlbumModel(id: 3, userId: 3, title: "quidem molestiae enim"),
        AlbumModel(id: 4, userId: 4, title: "quidem molestiae enim"),
        AlbumModel(id: 5, userId: 5, title: "quidem molestiae enim"),
        AlbumModel(id: 6, userId: 6, title: "quidem molestiae enim"),
        AlbumModel(id: 7, userId: 7, title: "quidem molestiae enim"),
        AlbumModel(id: 8, userId: 8, title: "quidem molestiae enim"),
        AlbumModel(id: 9, userId: 9, title: "quidem molestiae enim"),
        AlbumModel(id: 10, userId: 10, title: "quidem molestiae enim")
    ]
    
    let photoList : [PhotoModel] = [
        PhotoModel(id: 1, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 2, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 3, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 4, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 5, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 6, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 7, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 8, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 9, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952"),
        PhotoModel(id: 10, albumId: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952")
    ]
    
    override func managedObjectContext() -> NSManagedObjectContext {
        return managedObjectContextLazy
    }
    
    lazy var managedObjectContextLazy: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try coordinator!.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        }
        catch {
            coordinator = nil
            print("Error")
        }
        
        return coordinator
    }()
    
    override func countAlbumData() -> Int {
        return 10
    }
    
    override func fetchAlbumListFromCoreData(pageId: Int) -> [AlbumModel] {
        return albumList
    }
    
    override func countPhotoFromCoreData(selectedAlbumId: Int) -> Int {
        return 10
    }
    
    override func fetchPhotoListFromCoreData(selectedAlbumId: Int, pageId: Int) -> [PhotoModel] {
        return photoList
    }
    
    override func prepareAlbumData(dataForSaving: [AlbumModel]) {
        return 
    }
}
