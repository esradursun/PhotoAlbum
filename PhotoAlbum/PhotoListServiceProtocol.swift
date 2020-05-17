//
//  PhotoListServiceProtocol.swift
//  PinchPhotoAlbum
//
//  Created by Esra Dursun on 21/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation

protocol PhotoListServiceProtocol {
    func fetchPhotoList(selectedAlbumId: Int, pageId: Int, completion: @escaping ([PhotoModel]?) -> ())
    func countPhotoFromCoreData(selectedAlbumId: Int) -> Int
    func isMorePhotoDataAvailableFromAPI(selectedAlbumId : Int, pageId: Int) -> Bool
}
