//
//  MockAlbumListService.swift
//  PinchPhotoAlbumTests
//
//  Created by Esra Dursun on 21/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
@testable import PinchPhotoAlbum

class MockAlbumListService {
    
    var shouldReturnError = false
    var fetchAlbumListWasCalled = false
    var countAlbumFromCoreDataWasCalled = false
    var isMoreDataAvailableFromAPIWasCalled = false
    
    enum MockServiceError : Error {
        case fetchAlbumList
        case countAlbumFromCoreData
        case isMoreDataAvailableFromAPI
    }
    
    func reset() {
        shouldReturnError = false
        fetchAlbumListWasCalled = false
        countAlbumFromCoreDataWasCalled = false
        isMoreDataAvailableFromAPIWasCalled = false
    }
    
    convenience init(){
        self.init(false)
    }
    
    init(_ shouldReturnError : Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    func getMockAlbumResponse() -> [AlbumModel] {
        let mockAlbumList : [AlbumModel] = [
            AlbumModel(id: 1, userId: 1, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 2, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 3, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 4, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 5, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 6, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 7, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 8, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 9, title: "quidem molestiae enim"),
            AlbumModel(id: 1, userId: 10, title: "quidem molestiae enim")
        ]
        return mockAlbumList
    }
    
}

extension MockAlbumListService : AlbumListServiceProtokol {
    func fetchAlbumList(pageId: Int, completion: @escaping ([AlbumModel]?) -> ()) {
        fetchAlbumListWasCalled = true
        
        if shouldReturnError {
            //completionHandler(nil, MockServiceError.fetchAlbumList)
            //completionHandler kullanmak lazim, service icini de buna gore duzenle
            //youtube videosunu tekrar izle
        } else {
            completion(getMockAlbumResponse())
        }
    }
    
    func countAlbumFromCoreData() -> Int {
        countAlbumFromCoreDataWasCalled = true
        if shouldReturnError {
            //completionHandler kullanmak lazim, service icini de buna gore duzenle
            //youtube videosunu tekrar izle
        } else {
            
        }
        
        //gercek test case yaz retur u duzelt
        return 1
    }
    
    func isMoreDataAvailableFromAPI(pageId: Int) -> Bool {
        isMoreDataAvailableFromAPIWasCalled = true
        
        if shouldReturnError {
            //completionHandler kullanmak lazim, service icini de buna gore duzenle
            //youtube videosunu tekrar izle
        } else {
            
        }
        
        //gercek test case yaz retur u duzelt
        return true
    }
    
    
}
