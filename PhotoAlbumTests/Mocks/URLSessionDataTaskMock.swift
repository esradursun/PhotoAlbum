//
//  URLSessionDataTaskMock.swift
//  PhotoAlbumTests
//
//  Created by Esra Dursun on 22/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
@testable import PhotoAlbum

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}
