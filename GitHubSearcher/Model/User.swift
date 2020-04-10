//
//  User.swift
//  GitHubSearcher
//
//  Created by Consultant on 4/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//
// https://developer.github.com/v3/users/

import Foundation

struct UserResults: Decodable {
    let results: [User]
}

class User: Decodable {
    // TODO: Check optionals
    var username: String
    var email: String
    var location: String
    var joinDate: String
    var followerCount: Int
    var followingCount: Int
    var biography: String
    var reposURL: String

    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case email, location
        case joinDate = "created_at"
        case followerCount = "followers"
        case followingCount = "following"
        case biography = "bio"
        case reposURL = "repos_url"
    }

    // TODO: initializer
}
