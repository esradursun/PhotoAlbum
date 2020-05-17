//
//  PinchPhotoAlbumTests.swift
//  PinchPhotoAlbumTests
//
//  Created by Esra Dursun on 17/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import XCTest
@testable import PinchPhotoAlbum

class PinchPhotoServiceTests: XCTestCase {

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
    
    let emptyPhotoList: [PhotoModel] = []
    
    let sessionMock = URLSessionMock(apiUrl: URL(string: "url")!)
    
    let coreDataMock = CoreDataManagerMock()
    
    var photoSerVice: PhotoListService = PhotoListService()
    
    override func setUp() {
        do {
            sessionMock.data = try JSONEncoder().encode(mockPhotoList)
        } catch {
            XCTFail()
        }
        
        photoSerVice = PhotoListService(session: sessionMock, coreDataManager: coreDataMock)
    }

    
}
