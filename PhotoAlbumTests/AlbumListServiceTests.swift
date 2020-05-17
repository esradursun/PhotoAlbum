//
//  AlbumListServiceSpec.swift
//  PhotoAlbumTests
//
//  Created by Esra Dursun on 21/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import XCTest
@testable import PhotoAlbum

class AlbumListServiceTests: XCTestCase {
    
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
    
    let emptyAlbumList: [AlbumModel] = []
    
    let sessionMock = URLSessionMock(apiUrl: URL(string: "url")!)
    let coreDataMock = CoreDataManagerMock()
    var albumService: AlbumListService = AlbumListService()
    
    override func setUp() {
        do {
            sessionMock.data = try JSONEncoder().encode(albumList)
        } catch {
            XCTFail()
        }
        
        albumService = AlbumListService(session: sessionMock, coreDataManager: coreDataMock)
    }
    
    func testFetchAlbumList_whenCoreDataHasEnoughData_shouldFetchFromCoreData() {
        var result: [AlbumModel]?
        albumService.fetchAlbumList(pageId: 1) { result = $0 }
        
        XCTAssertEqual(result, coreDataMock.albumList)
    }
    
    func testFetchAlbumList_whenCoreDataHasNotEnoughData_shouldFetchFromAPI() {
        
        class MockCoreData: CoreDataManagerMock {
            @objc override func countAlbumData() -> Int {
                return 0
            }
        }
        var result: [AlbumModel]?
        albumService = AlbumListService(session: sessionMock, coreDataManager: MockCoreData())
        
        albumService.fetchAlbumList(pageId: 1) { result = $0 }
        
        XCTAssertEqual(result, albumList)
    }
    
    func testCountAlbum_shouldReturnCoreDataCount() {
        let result = albumService.countAlbumFromCoreData()
        
        XCTAssertEqual(result, 10)
    }
    
    func testIsMoreDataAvailable_whenPassedCountLessThanCoreDataCount_shouldReturnTrue() {
        albumService.isMoreDataAvailable(listedAlbumCount: 1, pageId: 1, completionHandler: { result in
            XCTAssert(result)
        })
    }
    
    func testIsMoreDataAvailable_whenPassedCountMoreThanCoreDataCountAndAPIHasData_shouldReturnTrue() {
        albumService.isMoreDataAvailable(listedAlbumCount: 100, pageId: 1, completionHandler: { result in
            XCTAssert(result)
        })
    }
    
    func testIsMoreDataAvailableWith_whenPassedCountMoreThanCoreDataCountAndAPIHasNoData_shouldReturnFalse() {
        
        do {
            sessionMock.data = try JSONEncoder().encode(emptyAlbumList)
        } catch {
            XCTFail()
        }
        albumService.isMoreDataAvailable(listedAlbumCount: 100, pageId: 1, completionHandler: { result in
            XCTAssertFalse(result)
        })
    }
    
}
