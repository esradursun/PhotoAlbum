//
//  AlbumService.swift
//  PhotoAlbum
//
//  Created by Esra Dursun on 17/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
import CoreData

class AlbumListService {
    
    private let session: URLSession
    private let coreDataManager: CoreDataManager
    
    init(session: URLSession = .shared, coreDataManager: CoreDataManager = .sharedManager) {
        self.session = session
        self.coreDataManager = coreDataManager
    }
    
    func fetchAlbumList(pageId: Int, completionHandler: @escaping ([AlbumModel]?) -> ()) {
        if countAlbumFromCoreData() >= (pageId * Constants.albumCountPerPage) {
            completionHandler(fetchAlbumListFromCoreData(pageId: pageId))
        } else {
            fetchAlbumListFromAPI(pageId: pageId) { albumList in
                if let albumFromApi = albumList {
                    self.saveAlbumList(albumFromApi)
                    completionHandler(albumFromApi)
                }
            }
        }
    }
    
    func countAlbumFromCoreData() -> Int {
        return self.coreDataManager.countAlbumData()
    }
    
    func isMoreDataAvailable(listedAlbumCount: Int, pageId: Int, completionHandler: @escaping (Bool) -> ()){
        if listedAlbumCount < countAlbumFromCoreData(){
            completionHandler(true)
        }
        else {
            fetchAlbumListFromAPI(pageId: pageId) { albumList in
                if let albums = albumList {
                    completionHandler(!albums.isEmpty)
                }
            }
        }
    }
    
    private func fetchAlbumListFromCoreData(pageId: Int) -> [AlbumModel] {
        return self.coreDataManager.fetchAlbumListFromCoreData(pageId: pageId)
    }
    
    private func fetchAlbumListFromAPI(pageId: Int, completionHandler: @escaping ([AlbumModel]?) -> ()) {
        let url = URL(string: "\(Constants.albumAPI)\(pageId)")!
        let task = session.dataTask(with: url){ data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completionHandler(nil)
            } else if let data = data {
                
                let albumList = try? JSONDecoder().decode([AlbumModel].self, from: data)
                if let albumList = albumList {
                    completionHandler(albumList)
                }
            }
        }
        task.resume()
    }
    
    private func saveAlbumList(_ albumList:[AlbumModel]){
        DispatchQueue.main.async {
            self.coreDataManager.prepareAlbumData(dataForSaving: albumList)
        }
    }
    
}
