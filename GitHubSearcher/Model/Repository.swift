//
//  Repository.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//
// https://developer.github.com/v3/repos/

import Foundation

struct Repository: Decodable {
    let url: String
    let name: String
    let forkCount: Int
    let starsCount: Int

    private enum CodingKeys: String, CodingKey {
        case name
        case url = "html_url"
        case forkCount = "forks_count"
        case starsCount = "stargazers_count"
       }
}
