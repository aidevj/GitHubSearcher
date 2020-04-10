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
    var name: String
    var forkCount: Int
    var stars: Int

    // TODO: Coding keys & initializer
}
