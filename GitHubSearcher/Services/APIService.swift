//
//  APIService.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

enum APIError: Error {
    case badURL(String)
    case badDataTask(String)
    case badDecoder(String)
}

typealias UserHandler = (Result<[User], APIError>) -> Void

let API = APIService.shared

final class APIService {

    static let shared = APIService()
    private init() {}

    // MARK: Get Users from API Call
    func getUsersFromApi(for search: String, completion: @escaping UserHandler) {

        guard let url = GitHubAPI(search).userURL else {
            completion(.failure(.badURL("Could not create Url")))
            return
        }

        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(.failure(.badDataTask("Bad Data Task: \(error.localizedDescription)")))
                return
            }

            if let data = dat {
                do {
                    let response = try JSONDecoder().decode(UserResults.self, from: data)
                    let users = response.results
                    completion(.success(users))
                } catch {
                    completion(.failure(.badDecoder(error.localizedDescription)))
                    return
                }
            }
        }.resume()
    } // END - getUsersFromApi func
}
