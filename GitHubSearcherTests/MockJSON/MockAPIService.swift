//
//  MockAPIService.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/14/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation
@testable import GitHubSearcher

enum MockJSON: String {
    case tomSearch = "https://api.github.com/search/users?q=Tom"
    case tomResults = "https://api.github.com/users/tom"
    case alwaysFail = "https://api.hitGub.com/search/moT"
    
    var fileName: String? {
        switch self {
        case .tomSearch:
            return "GitHubSearchResults_Tom"
        case .tomResults:
            return "GitHubUserResponse_Tom"
        default:
            return nil
        }
    }
}

extension APIError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .badDataTask(let str):
                return str
        case .badDecoder(let str):
                return str
        case .badURL(let str):
            return str
        }
    }
}

class MockAPIService: APIServiceProtocol {
    
    func get<T: Decodable>(type: T.Type, for url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        get(type: type, for: url.absoluteString, completion: completion)
    }
    
    func get<T: Decodable>(type: T.Type, for urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let fileName = MockJSON(rawValue: urlString) else {
            completion(.failure(.badURL("This Mock file does not exist")))
            return
        }
        guard let path = Bundle(for: MockAPIService.self).path(forResource: fileName.fileName,
                                                               ofType: "json") else {
            completion(.failure(.badURL("This Mock file is missing")))
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let results = try JSONDecoder().decode(type, from: data)
            completion(.success(results))
        } catch {
            completion(.failure(.badDecoder("Error with decoding file: \(error)")))
        }
    }
    
}
