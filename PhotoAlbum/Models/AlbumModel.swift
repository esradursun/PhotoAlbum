//
//  AlbumModel.swift
//  PhotoAlbum
//
//  Created by Esra Dursun on 17/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation

struct AlbumModel : Codable, Equatable {
    let userId : Int
    let id : Int
    let title : String
    
    init(id: Int, userId: Int, title: String) {
        self.id = id
        self.userId = userId
        self.title = title
    }
}
