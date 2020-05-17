//
//  CoreDataManager.swift
//  PhotoAlbum
//
//  Created by Esra Dursun on 19/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotoAlbum")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func prepareAlbumData(dataForSaving: [AlbumModel]){
        _ = dataForSaving.map{self.createEntityFromAlbum(album: $0)}
        saveContext()
    }
    
    func preparePhotoData(dataForSaving: [PhotoModel], selectedAlbumId: Int){
        _ = dataForSaving.map{self.createEntityFromPhoto(photo: $0, selectedAlbumId: selectedAlbumId)}
        saveContext()
    }
    
    func saveContext(){
        let context = self.managedObjectContext
        if context().hasChanges {
            do {
                try context().save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func countAlbumData() -> Int {
        let request : NSFetchRequest<Album> = Album.fetchRequest()
        var albumCount = 0
        do {
            albumCount  = try self.managedObjectContext().count(for: request)
        } catch {
            print("Error fetch album count \(error)")
        }
        return albumCount
    }
    
    func countPhotoFromCoreData(selectedAlbumId: Int) -> Int {
        let request = NSFetchRequest<Photo>(entityName: "Photo")
        request.predicate = NSPredicate(format: "albumId == \(Int16(selectedAlbumId))")
        var photoCount = 0
        
        do {
            photoCount  = try self.managedObjectContext().count(for: request)
        } catch {
            print("Error fetch photo count \(error)")
        }
        return photoCount
    }
    
    func fetchAlbumListFromCoreData(pageId: Int) -> [AlbumModel] {
        let request : NSFetchRequest<Album> = Album.fetchRequest()
        var albumModelList = [AlbumModel]()
        do{
            request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            request.fetchOffset = (pageId-1) * 10
            request.fetchBatchSize = 10
            request.fetchLimit = 10
            let albumFromCoreData = try self.managedObjectContext().fetch(request)
            
            for i in albumFromCoreData {
                let albumModel = AlbumModel(id: Int(i.id), userId: Int(i.userId), title: i.title!)
                albumModelList.append(albumModel)
            }
        } catch {
            print("Error loading album \(error)")
        }
        return albumModelList
    }
    
    func fetchPhotoListFromCoreData(selectedAlbumId: Int, pageId: Int) -> [PhotoModel] {
        let request : NSFetchRequest<Photo> = Photo.fetchRequest()
        request.predicate = NSPredicate(format: "albumId == \(Int16(selectedAlbumId))")
        var photoModelList = [PhotoModel]()
        
        do{
            request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
            request.fetchOffset = (pageId-1) * 10
            request.fetchBatchSize = 10
            request.fetchLimit = 10
            
            let photoListFromCoreData = try self.managedObjectContext().fetch(request)
            for i in photoListFromCoreData {
                let photoVM = PhotoModel(id: Int(i.id), albumId: Int(i.albumId), title: i.title!, url: i.url!, thumbnailUrl: i.thumbnailUrl!)
                photoModelList.append(photoVM)
            }
        } catch {
            print("Error loading photo \(error)")
        }
        return photoModelList
    }
    
    private func createEntityFromAlbum(album: AlbumModel) -> Album?{
        let albumItem = Album(context: self.managedObjectContext())
        albumItem.title = album.title
        albumItem.id = Int16(album.id)
        albumItem.userId = Int16(album.userId)
        return albumItem
    }
    
    private func createEntityFromPhoto(photo: PhotoModel, selectedAlbumId: Int) -> Photo?{
        
        let photoItem = Photo(context: self.managedObjectContext())
        
        photoItem.albumId = Int16(photo.albumId)
        photoItem.id = Int16(photo.id)
        photoItem.thumbnailUrl = photo.thumbnailUrl
        photoItem.url = photo.url
        photoItem.title = photo.title
        
        let request : NSFetchRequest<Album> = Album.fetchRequest()
        request.predicate = NSPredicate(format: "id == \(Int16(selectedAlbumId))")
        do {
            let selectedAlbum = try self.managedObjectContext().fetch(request).first
            photoItem.album = selectedAlbum
        } catch {
            print("createEntityFromPhoto: Error loading album \(error)")
        }
        return photoItem
    }
}
