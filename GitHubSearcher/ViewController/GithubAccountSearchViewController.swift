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
        //setupDummyData() //TODO: Erase for finalized API call
        setupTable()
        setupNavigation()

        viewModel.getUsers("tom+repos:%3E42+followers:%3E1000")
    }

    private func setupTable() {
        mainTableView.register(UINib(nibName: UserPreviewViewCell.identifier, bundle: Bundle.main),
                               forCellReuseIdentifier: UserPreviewViewCell.identifier)
        mainTableView.tableFooterView = UIView(frame: .zero)

        // Set View Model delegate
        viewModel.delegate = self
    }

    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Github Searcher"
    }

    // swiftlint:disable line_length
    private func setupDummyData() {
        userData = [
            User(username: "Test1",
                 email: "test@test.com",
                 loc: "Tampa, Florida",
                 join: "1/2/34",
                 followers: 4,
                 following: 5,
                 bio: "No bio",
                 repoURL: "https://testurl.com",
                 reposCount: 2,
                 avaURL: "https://img.pngio.com/ceshi-test-testing-icon-with-png-and-vector-format-for-free-testing-png-512_512.png"),
            User(username: "Test2",
                 email: "test@test.com",
                 loc: "Tampa, Florida",
                 join: "5/6/78",
                 followers: 4,
                 following: 5,
                 bio: "No bio",
                 repoURL: "https://testurl.com",
                 reposCount: 5,
                 avaURL: "https://img.pngio.com/ceshi-test-testing-icon-with-png-and-vector-format-for-free-testing-png-512_512.png"),
            User(username: "Test3",
                 email: "test@test.com",
                 loc: "Tampa, Florida",
                 join: "9/10/11",
                 followers: 4,
                 following: 5,
                 bio: "No bio",
                 repoURL: "https://testurl.com",
                 reposCount: 11,
                 avaURL: "https://img.pngio.com/ceshi-test-testing-icon-with-png-and-vector-format-for-free-testing-png-512_512.png")
        ]
    }
}

extension GithubAccountSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
//        return userData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserPreviewViewCell.identifier,
                                                 for: indexPath) as! UserPreviewViewCell
        let currentUser = viewModel.users[indexPath.row]
//        let currentUser = userData[indexPath.row]
        cell.user = currentUser

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let nextVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController")
//            as! DetailViewController

//        nextVC.hidesBottomBarWhenPushed = true

//        let selectedUser = viewModel.Users[indexPath.row]

//        viewModel.currentUser = selectedUser
//        navigationController?.view.backgroundColor = .none
//        navigationController?.pushViewController(nextVC, animated: true)
//        nextVC.viewModel = viewModel
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension GithubAccountSearchViewController: ViewModelDelegate {
    func update() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}
