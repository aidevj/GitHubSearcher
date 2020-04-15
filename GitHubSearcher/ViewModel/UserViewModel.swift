//
//  UserViewModel.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

class UserViewModel {
    
    private let user: User
    private let service: APIServiceProtocol
    private let pictureCache: PictureCache
    private var _repos = [Repository]() {
        didSet {
            self.repos = _repos
        }
    }
    private var repos = [Repository]() {
        didSet {
            self.updateHandler?()
        }
    }
    
    private var updateHandler: UpdateHandler?
    private var currentSearch: DispatchWorkItem?
    
    init(user: User, pictureCache: PictureCache = PictureCache(), service: APIServiceProtocol = APIService()) {
        self.user = user
        self.pictureCache = pictureCache
        self.service = service
    }
    
}

extension UserViewModel {
    
    func bind(_ updateHandler: @escaping UpdateHandler) {
        self.updateHandler = updateHandler
    }
    
    func bindAndFire(_ updateHandler: @escaping UpdateHandler) {
        self.updateHandler = updateHandler
        updateHandler()
    }
    
}

// MARK: User Data Accessors

extension UserViewModel {
    
    var userName: String {
        user.username
    }
    
    var email: String? {
        user.email
    }
    
    var location: String? {
        user.location
    }
    
    var joinDate: String {
        var joinDate = user.joinDate
        if let date = joinDate.toDate() {
            joinDate = date.toString()
        }
        return joinDate
    }
    
    var followers: String {
        user.followerCount.toString() + " Followers"
    }
    
    var following: String {
        "Following " + user.followingCount.toString()
    }
    
    var biography: String {
        user.biography ?? "unknown"
    }
    
    private func imageUrl(for index: Int) -> String? {
        guard index >= 0 && index < reposCount else { return nil }
        return user.avatarURL
    }
    
    func image(for index: Int, _ completion: @escaping (Data?) -> Void) {
        guard index >= 0
            && index < reposCount,
            let imageUrl = imageUrl(for: index),
            let url = URL(string: imageUrl) else {
                completion(nil)
                return
        }
        pictureCache.get(url, completion)
    }
}

// MARK: Repo Data Accessors

extension UserViewModel {
    var reposCount: Int {
        repos.count
    }
    
    func repoName(for index: Int) -> String? {
        guard index >= 0 && index < reposCount else { return nil }
        return repos[index].name
    }
    
    func forkCount(for index: Int) -> String {
        guard index >= 0 && index < reposCount else { return "0 Forks" }
        return repos[index].forkCount.toString() + " Forks"
    }
    
    func starsCount(for index: Int) -> String {
        guard index >= 0 && index < reposCount else { return "0 Stars" }
        return repos[index].starsCount.toString() + " Stars"
    }
    
    func url(for index: Int) -> URL? {
        guard index >= 0 && index < reposCount else { return nil }
        return URL(string: repos[index].url)
    }
}

extension UserViewModel {
    func fetchRepos() {
        service.get(type: [Repository].self, for: user.reposURL) { result in
            switch result {
            case .success(let repos):
                self._repos = repos
            case .failure:
                // TODO: - show some error on screen
                self._repos = []
            }
        }
    }
    
    func filter(term: String) {
        let searchTerm = term.lowercased()
        if searchTerm.isEmpty {
            self.repos = self._repos
            return
        }
        throttleSearch {
            self.repos = self._repos.filter { $0.name.lowercased().contains(searchTerm) }
        }
    }
    
    func throttleSearch(block: @escaping () -> Void) {
        // cancel the previous enqueued request
        currentSearch?.cancel()
        
        // define a new request
        currentSearch = DispatchWorkItem(block: block)
        
        // if user stops typing for a second, perform that request
        let deadline: DispatchTime = .now() + 0.5
        if let search = currentSearch {
            DispatchQueue.global(qos: .utility).asyncAfter(deadline: deadline, execute: search)
        }
    }

}
