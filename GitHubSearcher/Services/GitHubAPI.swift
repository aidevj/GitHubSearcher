//
//  GitHubAPI.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

typealias SearchResultsHandler = (Result<UserSearchResultsContainer, APIError>) -> Void
typealias UserHandler = (Result<[User], APIError>) -> Void

private enum GitHubConstants {
    static let root = "https://api.github.com"
    static let search = "/search/users?q="
    static let searchDelay: TimeInterval = 0.5
}

class GitHubAPI {

    // Example: https://api.github.com/search/users?q=tom+repos:%3E42+followers:%3E1000

    private let service: APIServiceProtocol
    private var currentSearch: DispatchWorkItem?
    
    init(service: APIServiceProtocol) {
        self.service = service
    }

    // MARK: Search Category URL Requests

}

// MARK: Networking
extension GitHubAPI {
    
    func throttleSearch(block: @escaping () -> Void) {
        // cancel the previous enqueued request
        currentSearch?.cancel()
        
        // define a new request
        currentSearch = DispatchWorkItem(block: block)
        
        // if user stops typing for a second, perform that request
        let deadline: DispatchTime = .now() + GitHubConstants.searchDelay
        if let search = currentSearch {
            DispatchQueue.global(qos: .utility).asyncAfter(deadline: deadline, execute: search)
        }
    }
        
    /// only fetches minimum details
    func search(user term: String, _ completion: @escaping SearchResultsHandler) {
        let searchUrl = makeSearchUrl(for: term)
        throttleSearch(block: {
            self.service.get(type: UserSearchResultsContainer.self, for: searchUrl, completion: completion)
        })
    }
    
    func userDetails(for userResult: UserSearchResult, _ completion: @escaping (Result<User, APIError>) -> Void) {
        userDetails(for: userResult.infoUrl, completion)
    }
    
    func userDetails(for userUrl: String, _ completion: @escaping (Result<User, APIError>) -> Void) {
        service.get(type: User.self, for: userUrl, completion: completion)
    }
    
    /// fetch full details for user
    func extensiveSearch(user term: String, _ completion: @escaping UserHandler) {
        throttleSearch(block: {
            self.search(user: term) { result in
                switch result {
                case .success(let result):
                    self.fetchInfo(for: result.users.self) { users in
                        completion(.success(users))
                    }
                case .failure(let apiError):
                    // TODO, something about error here
                    completion(.failure(apiError))
                }
            }
        })
    }
    
    private func fetchInfo(for users: [UserSearchResult], _ completion: @escaping ([User]) -> Void) {
        let group = DispatchGroup()
        var userInfos = [User]()
        let lock = NSLock()
        for user in users {
            group.enter()
            service.get(type: User.self, for: user.infoUrl) { (result) in
                if case let Result.success(userInfo) = result {
                    lock.lock()
                    userInfos.append(userInfo)
                    lock.unlock()
                }
                group.leave()
            }
        }
        group.notify(queue: .global(qos: .utility)) {
            completion(userInfos)
        }
    }
    
}

// MARK: URL Builder
extension GitHubAPI {
    private func makeSearchUrl(for searchTerm: String) -> String {
        return GitHubConstants.root
            + GitHubConstants.search
            + searchTerm
    }
}
