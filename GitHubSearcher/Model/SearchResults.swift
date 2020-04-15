//
//  SearchResults.swift
//  Created 4/14/20
//  Using Swift 5.0
// 
//  Copyright © 2020 MAC. All rights reserved.
//
//  https://github.com/1985wasagoodyear
//

import Foundation

struct UserSearchResultsContainer: Decodable {
    let users: [UserSearchResult]
    
    private enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

struct UserSearchResult: Decodable {
    let name: String
    let avatarUrl: String
    let infoUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatarUrl = "avatar_url"
        case infoUrl = "url"
    }
}
