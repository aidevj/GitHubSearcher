//
//  User.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//
// https://developer.github.com/v3/users/

import Foundation

struct UserResults: Decodable {
    let results: [User]
}

// swiftlint:disable identifier_name
class User: Decodable {
    // TODO: Check optionals
    var username: String?
    var email: String?
    var location: String?
    var joinDate: String?
    var followerCount: Int?
    var followingCount: Int?
    var biography: String?
    var reposURL: String?
    var reposCount: Int?
    var avatarURL: String?

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

    // Optional initializer
    init?(_ dict: [String: Any]) {
        guard let _username = dict["login"] as? String,
            let _email = dict["email"] as? String,
            let _loc = dict["location"] as? String,
            let _join = dict["created_at"] as? String,
            let _follower = dict["followers"] as? Int,
            let _following = dict["following"] as? Int,
            let _bio = dict["bio"] as? String,
            let _repoUrl = dict["repos_url"] as? String,
            let _repoCount = dict["public_repos"] as? Int,
            let _avatar = dict["avatar_url"] as? String
        else { return nil } // Question: Do we need the coding keys if putting in dict keys as is (or vice versa)?
                            // i.e. let _following = dict[following] as? Int

        self.username = _username
        self.email = _email
        self.location = _loc
        self.joinDate = _join
        self.followerCount = _follower
        self.followingCount = _following
        self.biography = _bio
        self.reposURL = _repoUrl
        self.reposCount = _repoCount
        self.avatarURL = _avatar
    }

    // Custom initializer for Testing
    init(username: String?,
         email: String?,
         loc: String?,
         join: String?,
         followers: Int?,
         following: Int?,
         bio: String?,
         repoURL: String?,
         reposCount: Int?,
         avaURL: String?
    ) {
        self.username = username ?? ""
        self.email = email ?? ""
        self.location = loc ?? ""
        self.joinDate = join ?? ""
        self.followerCount = followers ?? 0
        self.followingCount = following ?? 0
        self.biography = bio ?? ""
        self.reposURL = repoURL ?? ""
        self.reposCount = reposCount ?? 0
        self.avatarURL = avaURL ?? nil
    }
}
