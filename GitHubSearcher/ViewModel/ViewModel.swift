//
//  ViewModel.swift
//  GitHubSearcher
//
//  Created by Consultant on 4/10/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func update()
}

class ViewModel {
    weak var delegate: ViewModelDelegate?

    var currentUser: User!

    var users = [User]() {
        didSet {
            delegate?.update()
        }
    }
}

extension ViewModel {
    func getUsers(_ userName: String) {
        API.getUsersFromApi(for: userName) { [weak self] apiResult in
            switch apiResult {
            case .success(let users):
                self?.users = users
                print("User Count: \(users.count)")
            case .failure(let error):
                print("API Failure: \(error.localizedDescription)")
            }
        }
    }
}
