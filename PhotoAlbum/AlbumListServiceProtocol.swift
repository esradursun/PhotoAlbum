//
//  AlbumListServiceProtocol.swift
//  PinchPhotoAlbum
//
//  Created by Esra Dursun on 21/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation

protocol AlbumListServiceProtokol {
    
    func fetchAlbumList(pageId: Int, completion: @escaping ([AlbumModel]?) -> ())
    func countAlbumFromCoreData() -> Int
    func isMoreDataAvailableFromAPI(pageId: Int) -> Bool
}
