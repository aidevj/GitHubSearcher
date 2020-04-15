//
//  UserSearchViewModel.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

typealias UpdateHandler = () -> Void

class UserSearchViewModel {

    private let service: APIServiceProtocol
    private let gitHubAPI: GitHubAPI
    private let pictureCache = PictureCache()
    
    private var users = [User]() {
        didSet {
            self.updateHandler?()
        }
    }
    
    private var updateHandler: UpdateHandler?
    
    init(service: APIServiceProtocol = APIService()) {
        self.service = service
        self.gitHubAPI = GitHubAPI(service: service)
    }
    
    func bind(_ updateHandler: @escaping UpdateHandler) {
        self.updateHandler = updateHandler
    }
    
    func bindAndFire(_ updateHandler: @escaping UpdateHandler) {
        self.updateHandler = updateHandler
        updateHandler()
    }
    
}

// MARK: Data accessors

extension UserSearchViewModel {
    var count: Int {
        users.count
    }
    
    func name(for index: Int) -> String? {
        guard index >= 0 && index < count else { return nil }
        return users[index].username
    }
    
    private func imageUrl(for index: Int) -> String? {
        guard index >= 0 && index < count else { return nil }
        return users[index].avatarURL
    }
    
    func reposCount(for index: Int) -> String? {
        guard index >= 0 && index < count else { return nil }
        return String(users[index].reposCount)
    }
    
    func image(for index: Int, _ completion: @escaping (Data?) -> Void) {
        guard index >= 0
            && index < count,
            let imageUrl = imageUrl(for: index),
            let url = URL(string: imageUrl) else {
                completion(nil)
                return
        }
        pictureCache.get(url, completion)
    }
    
    func viewModel(for index: Int) -> UserViewModel? {
        guard index >= 0 && index < count else { return nil }
        return UserViewModel(user: users[index], pictureCache: pictureCache, service: service)
    }
    
}

// MARK: Networking

extension UserSearchViewModel {
    func getUsers(_ userName: String) {
        if userName.isEmpty {
            return
        }
        gitHubAPI.extensiveSearch(user: userName) { result in
            switch result {
            case .success(let result):
                self.users = result
            case .failure:
                // TODO: - show some error on screen
                self.users = []
            }
        }

    }
}
