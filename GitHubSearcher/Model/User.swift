//
//  User.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//
// https://developer.github.com/v3/users/

import Foundation

struct User: Decodable {
    let username: String
    let email: String?
    let location: String?
    let joinDate: String
    let followerCount: Int
    let followingCount: Int
    let biography: String?
    let reposURL: String
    let reposCount: Int
    let avatarURL: String

    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case email, location
        case joinDate = "created_at"
        case followerCount = "followers"
        case followingCount = "following"
        case biography = "bio"
        case reposURL = "repos_url"
        case reposCount = "public_repos"
        case avatarURL = "avatar_url"
    }

}
