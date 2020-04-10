//
//  GitHubAPI.swift
//  GitHubSearcher
//
//  Created by Consultant on 4/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

struct GitHubAPI {

    // Example: https://api.github.com/search/users?q=tom+repos:%3E42+followers:%3E1000

    let root = "https://api.github.com"
    let search = "/search/users?q="
    var searchTerm: String!

    init(_ searchTerm: String? = nil) {
        self.searchTerm = searchTerm
    }

    // MARK: Search Category URL Requests
    var userURL: URL? {
        guard let query = searchTerm else { return nil }
        return URL(string: root + search + query)
    }
}

