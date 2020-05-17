//
//  AlbumListViewModel.swift
//  PinchPhotoAlbum
//
//  Created by Esra Dursun on 18/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation

//protocol AlbumViewModelDelegate: class {
//  func onFetchCompleted(with albumList: [AlbumViewModel]?)
//  func onFetchFailed(with reason: String)
//}

class AlbumViewModel {
    private var album: AlbumModel
    var albumService = AlbumListService()
    
    
    init(album: AlbumModel) {
        self.album = album
    }
    
//    func fetchAlbumList(pageId: Int) -> [AlbumModel] {
//        var albumList = [AlbumModel]()
//        albumService.fetchAlbumList(pageId: pageId) { albums in
//            if let albums = albums {
//                albumList = albums
//            }
//        }
//        return albumList
//    }

    var id: Int {
        return album.id
    }
    
    var userId: Int {
        return album.userId
    }
    
    var title: String {
        return album.title
    }
    

    
}
