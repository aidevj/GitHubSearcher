//
//  DetailViewController.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    
    let viewModel: UserViewModel

    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: RepoViewCell.identifier, bundle: .main)
        detailTableView.register(nib,
                                 forCellReuseIdentifier: RepoViewCell.identifier)
        let nib2 = UINib(nibName: UserDetailViewCell.identifier, bundle: .main)
        detailTableView.register(nib2,
                               forCellReuseIdentifier: UserDetailViewCell.identifier)
        detailTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupViewModel() {
        viewModel.bind {
            DispatchQueue.main.async {
                self.detailTableView.reloadSections(IndexSet(integer: 1),
                                                    with: .automatic)
            }
        }
        viewModel.fetchRepos()
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.reposCount
        default:
            fatalError("Bad section")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return headerCell(at: indexPath)
        case 1:
            return repoCell(at: indexPath)
        default:
            fatalError("Bad section")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = viewModel.url(for: indexPath.row) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}

extension DetailViewController {
    
    func headerCell(at indexPath: IndexPath) -> UserDetailViewCell {
        guard let cell = detailTableView.dequeueReusableCell(withIdentifier: UserDetailViewCell.identifier,
                                                       for: indexPath) as? UserDetailViewCell else {
                                                        fatalError("Could not dequeue a cell")
        }
        let row = indexPath.row
        viewModel.image(for: row) { (data) in
            DispatchQueue.main.async {
                guard let data = data else {
                    cell.avatarImageView.image = nil
                    return
                }
                cell.avatarImageView.image = UIImage(data: data)
            }
        }
        cell.searchBar.delegate = self
        cell.usernameLabel.text = viewModel.userName
        cell.emailLabel.text = viewModel.email
        cell.locationLabel.text = viewModel.location
        cell.joinDateLabel.text = viewModel.joinDate
        cell.followersCountLabel.text = viewModel.followers
        cell.followingCountLabel.text = viewModel.following
        cell.biographyLabel.text = viewModel.biography
        return cell
    }
    
    func repoCell(at indexPath: IndexPath) -> RepoViewCell {
        guard let cell = detailTableView.dequeueReusableCell(withIdentifier: RepoViewCell.identifier,
                                                       for: indexPath) as? RepoViewCell else {
                                                        fatalError("Could not dequeue a cell")
        }
        let row = indexPath.row
        cell.nameLabel.text = viewModel.repoName(for: row)
        cell.starsCountLabel.text = viewModel.starsCount(for: row)
        cell.forksCountLabel.text = viewModel.forkCount(for: row)
        return cell
    }
}

extension DetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(term: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            viewModel.filter(term: text)
        }
    }
}
