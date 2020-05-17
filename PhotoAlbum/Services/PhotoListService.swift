//
//  PhotoService.swift
//  PhotoAlbum
//
//  Created by Esra Dursun on 17/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
import CoreData

class PhotoListService {
    
    private let session: URLSession
    private let coreDataManager: CoreDataManager
    
    init(session: URLSession = .shared, coreDataManager: CoreDataManager = .sharedManager) {
        self.session = session
        self.coreDataManager = coreDataManager
    }
    
    func fetchPhotoList(selectedAlbumId: Int, pageId: Int, completionHandler: @escaping ([PhotoModel]?) -> ()) {
        if countPhotoFromCoreData(selectedAlbumId: selectedAlbumId) >= (pageId * Constants.photoCountPerPage)  {
            completionHandler(fetchPhotoListFromCoreData(selectedAlbumId: selectedAlbumId, pageId: pageId))
        } else {
            fetchPhotoListFromAPI(pageId: pageId, selectedAlbumId: selectedAlbumId) { photoList in
                if let photoFromApi = photoList {
                    self.savePhotoList(photoList: photoFromApi, selectedAlbumId: selectedAlbumId)
                    completionHandler(photoFromApi)
                }
            }
        }
    }
    
    func countPhotoFromCoreData(selectedAlbumId: Int) -> Int {
        return self.coreDataManager.countPhotoFromCoreData(selectedAlbumId: selectedAlbumId)
    }
    
    func isMoreDataAvailable(listedPhotoCount: Int,selectedAlbumId: Int,  pageId: Int, completionHandler: @escaping (Bool) -> ()){
        if listedPhotoCount < countPhotoFromCoreData(selectedAlbumId: selectedAlbumId){
            completionHandler(true)
        }
        else {
            fetchPhotoListFromAPI(pageId: pageId, selectedAlbumId: selectedAlbumId) { photoList in
                if let photos = photoList {
                    completionHandler(!photos.isEmpty)
                }
            }
        }
    }
    
    private func fetchPhotoListFromCoreData(selectedAlbumId: Int, pageId: Int) -> [PhotoModel] {
        return self.coreDataManager.fetchPhotoListFromCoreData(selectedAlbumId: selectedAlbumId, pageId: pageId)
    }
    
    private func fetchPhotoListFromAPI(pageId: Int, selectedAlbumId: Int, completionHandler: @escaping ([PhotoModel]?) -> ()) {
        let url = URL(string: "\(Constants.photoAPI)?albumId=\(selectedAlbumId)&_page=\(pageId)")!
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completionHandler(nil)
            } else if let data = data {
                let photoList = try? JSONDecoder().decode([PhotoModel].self, from: data)
                
                if let photoList = photoList {
                    completionHandler(photoList)
                }
            }
        }
        task.resume()
    }
    
    private func savePhotoList(photoList: [PhotoModel], selectedAlbumId : Int){
        DispatchQueue.main.async {
            CoreDataManager.sharedManager.preparePhotoData(dataForSaving: photoList, selectedAlbumId: selectedAlbumId)
        }
    }
}
