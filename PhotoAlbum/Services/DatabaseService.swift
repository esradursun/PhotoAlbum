//
//  DatabaseService.swift
//  PinchPhotoAlbum
//
//  Created by Esra Dursun on 22/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
import CoreData

class DatabaseService {
    var persistentContainer: NSPersistentContainer!
    var managedObjectContext: NSManagedObjectContext!

    init(coreData: CoreDataManagerProtocol = CoreDataManager()) {
        persistentContainer = coreData.persistentContainer
        managedObjectContext = coreData.managedObjectContext
    }
    
    func prepareAlbumData(dataForSaving: [AlbumModel]){
        _ = dataForSaving.map{self.createEntityFromAlbum(album: $0)}
        saveContext()
    }
    
    private func createEntityFromAlbum(album: AlbumModel) -> Album?{
        let albumItem = Album(context: managedObjectContext)
        albumItem.title = album.title
        albumItem.id = Int16(album.id)
        albumItem.userId = Int16(album.userId)
        return albumItem
    }
    
    func preparePhotoData(dataForSaving: [PhotoModel], selectedAlbumId: Int){
        _ = dataForSaving.map{self.createEntityFromPhoto(photo: $0, selectedAlbumId: selectedAlbumId)}
        saveContext()
    }
    
    private func createEntityFromPhoto(photo: PhotoModel, selectedAlbumId: Int) -> Photo?{

        let photoItem = Photo(context: managedObjectContext)
        //photo id ile album id iliskili olmali
        
        photoItem.albumId = Int16(photo.albumId)
        photoItem.id = Int16(photo.id)
        photoItem.thumbnailUrl = photo.thumbnailUrl
        photoItem.url = photo.url
        photoItem.title = photo.title
        
        let request : NSFetchRequest<Album> = Album.fetchRequest()
//        let predicate = NSPredicate(format: "id CONTAINS[cd] %@", Int16(selectedAlbumId))
//        request.predicate = predicate
        
        
//        do {
//            let selectedAlbum = try self.managedObjectContext.fetch(request)
//
//            photoItem.album = selectedAlbum
//            } catch {
//                print("Error loading photo \(error)")
//            }
        
        return photoItem
            
    }
    
}
