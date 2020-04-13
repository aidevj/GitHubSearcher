//
//  ViewController.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast
class GithubAccountSearchViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!

    // MARK: Properties

    // Entry point for ViewModel
    var viewModel = ViewModel()

    var userData: [User] = []

    // MARK: Functionality

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Github Searcher"
        setupDummyData() //TODO: Erase for finalized API call
        setupTable()
    }

    private func setupTable() {
        mainTableView.register(UINib(nibName: UserPreviewViewCell.identifier, bundle: Bundle.main),
                               forCellReuseIdentifier: UserPreviewViewCell.identifier)
        mainTableView.tableFooterView = UIView(frame: .zero)

        // Set View Model delegate
        viewModel.delegate = self
        // TODO: Set up search bar
    }

    private func setupDummyData() {
        userData = [
            User(username: "Test1",
                 email: "test@test.com",
                 loc: "Tampa, Florida",
                 join: "1/2/34",
                 followers: 4,
                 following: 5,
                 bio: "No bio",
                 repoURL: "https://testurl.com"),
            User(username: "Test2",
                 email: "test@test.com",
                 loc: "Tampa, Florida",
                 join: "5/6/78",
                 followers: 4,
                 following: 5,
                 bio: "No bio",
                 repoURL: "https://testurl.com"),
            User(username: "Test3",
                 email: "test@test.com",
                 loc: "Tampa, Florida",
                 join: "9/10/11",
                 followers: 4,
                 following: 5,
                 bio: "No bio",
                 repoURL: "https://testurl.com")
        ]
    }
}

extension GithubAccountSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.users.count
        return userData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserPreviewViewCell.identifier,
                                                 for: indexPath) as! UserPreviewViewCell
//        let currentUser = viewModel.users[indexPath.row]
        let currentUser = userData[indexPath.row]
        cell.user = currentUser

        return cell
    }
}

extension GithubAccountSearchViewController: ViewModelDelegate {
    func update() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}
