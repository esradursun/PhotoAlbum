//
//  PhotoListServiceTests.swift
//  PhotoAlbumTests
//
//  Created by Esra Dursun on 22/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import XCTest
@testable import PhotoAlbum

class PhotoListServiceTests: XCTestCase {

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
    
    let emptyPhotoList: [PhotoModel] = []
    let sessionMock = URLSessionMock(apiUrl: URL(string: "url")!)
    let coreDataMock = CoreDataManagerMock()
    var photoService: PhotoListService = PhotoListService()
    
    override func setUp() {
        do {
            sessionMock.data = try JSONEncoder().encode(photoList)
        } catch {
            XCTFail()
        }
        
        photoService = PhotoListService(session: sessionMock, coreDataManager: coreDataMock)
    }

    func testFetchPhotoList_whenCoreDataHasEnoughData_shouldFetchFromCoreData() {
        var result: [PhotoModel]?
        photoService.fetchPhotoList(selectedAlbumId: 1, pageId: 1) { result = $0 }
        
        XCTAssertEqual(result, coreDataMock.photoList)
    }
    
    func testFetchPhotoList_whenCoreDataHasNotEnoughData_shouldFetchFromAPI() {
        
        class MockCoreData: CoreDataManagerMock {
            @objc override func countPhotoFromCoreData(selectedAlbumId: Int) -> Int {
                return 0
            }
        }
        var result: [PhotoModel]?
        photoService = PhotoListService(session: sessionMock, coreDataManager: MockCoreData())
        
        photoService.fetchPhotoList(selectedAlbumId: 1, pageId: 1) { result = $0 }
        
        XCTAssertEqual(result, photoList)
    }
    
    func testCountPhoto_shouldReturnCoreDataCount() {
        let result = photoService.countPhotoFromCoreData(selectedAlbumId: 1)
        
        XCTAssertEqual(result, 10)
    }
    
    func testIsMoreDataAvailable_whenPassedCountLessThanCoreDataCount_shouldReturnTrue() {
        photoService.isMoreDataAvailable(listedPhotoCount: 1, selectedAlbumId: 1, pageId: 1, completionHandler: { result in
            XCTAssert(result)
        })
    }
    
    func testIsMoreDataAvailable_whenPassedCountMoreThanCoreDataCountAndAPIHasData_shouldReturnTrue() {
        photoService.isMoreDataAvailable(listedPhotoCount: 100, selectedAlbumId: 1,pageId: 1, completionHandler: { result in
            XCTAssert(result)
        })
    }
    
    func testIsMoreDataAvailable_whenPassedCountMoreThanCoreDataCountAndAPIHasNoData_shouldReturnFalse() {
        
        do {
            sessionMock.data = try JSONEncoder().encode(emptyPhotoList)
        } catch {
            XCTFail()
        }
        photoService.isMoreDataAvailable(listedPhotoCount: 100, selectedAlbumId: 1,pageId: 1, completionHandler: { result in
            XCTAssertFalse(result)
        })
    }

}
