//
//  EndpointExecutor.swift
//  Assignment
//
//  Created by Hitesh Kumar on 10/09/19.
//  Copyright © 2019 Hitesh Kumar. All rights reserved.
//

import Foundation
/*
 Endpoint executor class to call api calls
 */
final class EndpointExecutor {
    
    private let session = URLSession(configuration: .default)
    private func callRequest<T: Codable>(_ request: Resource,
                                         completion: @escaping (Result<T>) -> Void) {
        guard Reachability.isConnectedToNetwork() else {
            completion(Result.error("Internet not available"))
            return
        }
        guard let urlRequest = request.getURLRequest() else {
            completion(.error("Invaid URL"))
            return
        }
        session.dataTask(with: urlRequest) { data, response, error in
                if let response = response as? HTTPURLResponse, response.statusCode == 200,
                    let data = data {
                    do {
                        let parsedResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(parsedResponse))
                    } catch {
                        completion(.error(error.localizedDescription))
                    }
                } else {
                    completion(.error(error?.localizedDescription ?? "Endpoint error"))
                }
            }.resume()
    }
}

// MARK: - JsonPlaceholderAPI

extension EndpointExecutor: JsonPlaceholderAPI {
    func posts(_ completion: @escaping (Result<[Post]>) -> Void) {
        callRequest(JsonPlaceholderServices.posts, completion: completion)
    }    
    func comments(postId: Int, completion: @escaping (Result<[Comment]>) -> Void) -> Void {
        callRequest(JsonPlaceholderServices.comments(postId: postId), completion: completion)
    }
}
