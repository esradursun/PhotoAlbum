//
//  PhotosModel.swift
//  PhotoAlbum
//
//  Created by Esra Dursun on 17/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation

struct PhotoModel : Codable, Equatable {
    let id : Int
    let albumId : Int
    let title : String
    let url : String
    let thumbnailUrl : String
    
    
    init(id: Int, albumId: Int, title: String, url: String, thumbnailUrl: String) {
        self.id = id
        self.albumId = albumId
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
}
