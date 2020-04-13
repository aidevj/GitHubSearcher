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
    //var reposCount : Int? //TODO: get number of items of in user repos url json

    private enum CodingKeys: String, CodingKey {
        case username = "login"
        case email, location
        case joinDate = "created_at"
        case followerCount = "followers"
        case followingCount = "following"
        case biography = "bio"
        case reposURL = "repos_url"
    }

    // Optional initializer
    init?(_ dict: [String: Any]) {
        guard let _username = dict["login"] as? String,
            let _email = dict["email"] as? String,
            let _loc = dict["location"] as? String,
            let _join = dict["created_at"] as? String,
            let _follower = dict["followers"] as? Int,
            let _following = dict["following"] as? Int, //let _following = dict[following] as? Int
            let _bio = dict["bio"] as? String,
            let _repos = dict["repos_url"] as? String
        else { return nil } // TODO: Do we need the coding keys if putting in dict keys as is (or vice versa)?

        self.username = _username
        self.email = _email
        self.location = _loc
        self.joinDate = _join
        self.followerCount = _follower
        self.followingCount = _following
        self.biography = _bio
        self.reposURL = _repos
    }

    // Custom initializer for Testing
    init(username: String?,
         email: String?,
         loc: String?,
         join: String?,
         followers: Int?,
         following: Int?,
         bio: String?,
         repoURL: String?
    ) {
        self.username = username ?? ""
        self.email = email ?? ""
        self.location = loc ?? ""
        self.joinDate = join ?? ""
        self.followerCount = followers ?? nil   //0 if not optional
        self.followingCount = following ?? nil  //0 if not optional
        self.biography = bio ?? ""
        self.reposURL = repoURL ?? ""
    }
}
