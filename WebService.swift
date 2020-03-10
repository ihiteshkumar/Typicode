//
//  JsonPlaceholderServices.swift
//  Assignment
//
//  Created by Hitesh Kumar on 10/09/19.
//  Copyright © 2019 Hitesh Kumar. All rights reserved.
//

import Foundation

struct WebServiceConstants {
    static let baseURL = "https://jsonplaceholder.typicode.com"
    static let postId = "postId"
}

enum Result<T> {
    case success(T)
    case error(String)
}

protocol Resource {
    func getURLRequest() -> URLRequest?
}

protocol ResourceConfiguration {
    var path: String { get }
    var queryParam: [URLQueryItem]? { get }
}

enum JsonPlaceholderServices: ResourceConfiguration, Resource {
    
    case posts
    case comments(postId: Int)

    var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .comments:
            return "/comments"
        }
    }
    // URL query parameters
    var queryParam: [URLQueryItem]? {
        switch self {
        case .comments(let postId):
            return [URLQueryItem.init(name: WebServiceConstants.postId, value: String(postId))]
        case .posts:
            return nil
        }
    }
    // Create url request
    func getURLRequest() -> URLRequest? {
        guard var urlComponent = URLComponents(string: WebServiceConstants.baseURL) else {
            return nil
        }
        if let queryParams = queryParam {
            urlComponent.queryItems = queryParams
        }
        urlComponent.path = path
        guard let url = urlComponent.url else {
            return nil
        }
        return URLRequest(url: url)
    }
}
