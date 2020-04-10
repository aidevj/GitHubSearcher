//
//  ViewController.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!

    // MARK: Properties

    // Entry point for ViewModel
    var viewModel = ViewModel()

    var userData: [User] = []

    // MARK: Functionality

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupTable() {
        mainTableView.register(UINib(nibName: UserViewCell.identifier, bundle: Bundle.main),
                               forCellReuseIdentifier: UserViewCell.identifier)
        mainTableView.tableFooterView = UIView(frame: .zero)

        // Set View Model delegate
        viewModel.delegate = self

        // TODO: Set up search bar
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Apply cell nib
        return UITableViewCell.init()
    }
}
