//
//  MockPhotoListAlbumService.swift
//  PinchPhotoAlbumTests
//
//  Created by Esra Dursun on 21/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
@testable import PinchPhotoAlbum

class MockPhotoListService {
    
    var shouldReturnError = false
    var fetchPhotoListWasCalled = false
    var countPhotoFromCoreDataWasCalled = false
    var isMorePhotoDataAvailableFromAPIWasCalled = false
     
     enum MockServiceError : Error {
         case fetchPhotoList
         case countPhotoFromCoreData
         case isMorePhotoDataAvailableFromAPI
     }
     
     func reset() {
         shouldReturnError = false
         fetchPhotoListWasCalled = false
         countPhotoFromCoreDataWasCalled = false
         isMorePhotoDataAvailableFromAPIWasCalled = false
     }
     
     convenience init(){
         self.init(false)
     }
     
     init(_ shouldReturnError : Bool) {
         self.shouldReturnError = shouldReturnError
     }
    
    func getMockPhotoResponse() -> [PhotoModel] {
        let mockPhotoList : [PhotoModel] = [
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
        return mockPhotoList
    }
    
}

extension MockPhotoListService : PhotoListServiceProtocol {
    func fetchPhotoList(selectedAlbumId: Int, pageId: Int, completion: @escaping ([PhotoModel]?) -> ()) {
        fetchPhotoListWasCalled = false
        if shouldReturnError {
            //completionHandler(nil, MockServiceError.fetchAlbumList)
            //completionHandler kullanmak lazim, service icini de buna gore duzenle
            //youtube videosunu tekrar izle
        } else {
            completion(getMockPhotoResponse())
        }
        
    }
    
    func countPhotoFromCoreData(selectedAlbumId: Int) -> Int {
        countPhotoFromCoreDataWasCalled = false
        
        return 1
    }
    
    func isMorePhotoDataAvailableFromAPI(selectedAlbumId: Int, pageId: Int) -> Bool {
        isMorePhotoDataAvailableFromAPIWasCalled = false
        
        return true
    }
    
    
}
