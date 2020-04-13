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

    var users = [User]() {
        didSet {
            //TODO
        }
    }
}

extension ViewModel {
    func getUsers(_ userName: String) {

    }
}
