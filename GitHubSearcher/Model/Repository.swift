//
//  Repository.swift
//  GitHubSearcher
//
//  Created by Consultant on 4/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//
// https://developer.github.com/v3/repos/

import Foundation

struct RepositoryResults: Decodable {
    let results: [Repository]
}

class Repository: Decodable {
    var url: String
    var name: String
    var forkCount: Int
    var starsCount: Int

    private enum CodingKeys: String, CodingKey {
        case name
        case url = "html_url"
        case forkCount = "forks_count"
        case starsCount = "stargazers_count"
       }
}
