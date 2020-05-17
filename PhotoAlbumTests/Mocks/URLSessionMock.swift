//
//  URLSessionMock.swift
//  PhotoAlbumTests
//
//  Created by Esra Dursun on 22/03/2020.
//  Copyright © 2020 Esra Dursun. All rights reserved.
//

import Foundation
@testable import PhotoAlbum


class URLSessionMock: URLSession {
    
    var apiUrl: URL = URL(string: "url")!
    init(apiUrl: URL) {
        self.apiUrl = apiUrl
    }
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var error: Error?

    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
