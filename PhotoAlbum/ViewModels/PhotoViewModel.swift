//
//  PhotoListViewModel.swift
//  PinchPhotoAlbum
//
//  Created by Esra Dursun on 18/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation


class PhotoViewModel {
    private var photo: PhotoModel
   
    init(photo: PhotoModel) {
        self.photo = photo
    }
    
    var id: Int {
        return photo.id
    }
    
    var albumId: Int {
        return photo.albumId
    }
    
    var title: String {
        return photo.title
    }
    
    var url: String {
        return photo.url
    }
    
    var thumbnailUrl: String {
        return photo.thumbnailUrl
    }
}





