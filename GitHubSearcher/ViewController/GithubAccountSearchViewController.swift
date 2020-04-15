//
//  GitHubAccountSearchViewController.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class GitHubAccountSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!

    // MARK: Properties
    
    var viewModel = UserSearchViewModel()

    // MARK: Functionality

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigation()
        setupViewModel()
    }

    private func setupTable() {
        let nib = UINib(nibName: UserPreviewViewCell.identifier, bundle: .main)
        mainTableView.register(nib,
                               forCellReuseIdentifier: UserPreviewViewCell.identifier)
        mainTableView.tableFooterView = UIView(frame: .zero)
    }

    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Github Searcher"
    }
    
    private func setupViewModel() {
        viewModel.bind {
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
}

extension GitHubAccountSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserPreviewViewCell.identifier,
                                                       for: indexPath) as? UserPreviewViewCell else {
                                                        fatalError("Could not dequeue a cell")
        }
        let row = indexPath.row
        setup(cell, row: row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let userViewModel = viewModel.viewModel(for: indexPath.row) {
            let detailViewController = DetailViewController(viewModel: userViewModel)
            present(detailViewController, animated: true)
        }
    }
}

extension GitHubAccountSearchViewController {
    
    func setup(_ cell: UserPreviewViewCell, row: Int) {
        cell.usernameLabel.text = viewModel.name(for: row)
        cell.repoCountLabel.text = viewModel.reposCount(for: row)
        viewModel.image(for: row) { (data) in
            DispatchQueue.main.async {
                guard let data = data else {
                    cell.userAvatarImage.image = nil
                    return
                }
                cell.userAvatarImage.image = UIImage(data: data)
            }
        }
    }
    
}

extension GitHubAccountSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getUsers(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            viewModel.getUsers(searchText)
        }
    }
}
