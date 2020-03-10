//
//  JsonPlaceholderAPI.swift
//  Assignment
//
//  Created by Hitesh Kumar on 10/09/19.
//  Copyright © 2019 Hitesh Kumar. All rights reserved.
//

/*
 Define all the Json Placeholder APIs here
 */
protocol JsonPlaceholderAPI {
    func posts(_ completion: @escaping (Result<[Post]>) -> Void) -> Void    
    func comments(postId: Int, completion: @escaping (Result<[Comment]>) -> Void) -> Void
}
