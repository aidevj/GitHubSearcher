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

protocol APIServiceProtocol {
    func get<T: Decodable>(type: T.Type,
                           for url: URL,
                           completion: @escaping (Result<T, APIError>) -> Void)
    func get<T: Decodable>(type: T.Type,
                           for urlString: String,
                           completion: @escaping (Result<T, APIError>) -> Void)
}

final class APIService: APIServiceProtocol {

    let session: URLSession
    
    init(_ session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
    
    func get<T: Decodable>(type: T.Type, for urlString: String, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL("Could not create Url")))
            return
        }
        get(type: type, for: url, completion: completion)
    }

    func get<T: Decodable>(type: T.Type, for url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        session.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(.failure(.badDataTask("Bad Data Task: \(error.localizedDescription)")))
                return
            }
            guard let data = dat else {
                completion(.failure(.badDataTask("No data returned")))
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                print(error)
                completion(.failure(.badDecoder(error.localizedDescription)))
            }
        }.resume()
    }
}
