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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init()
    }
}

extension DetailViewController: ViewModelDelegate {
    func update() {
        //TODO
    }
}
