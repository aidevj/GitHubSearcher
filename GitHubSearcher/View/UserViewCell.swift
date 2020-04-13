//
//  UserViewCell.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class UserPreviewViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIStackView! // wrong
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repoCountLabel: UILabel!

    var user: User! { //TODO: handle case where user data is nil
        didSet {
            usernameLabel.text = user.username
//            repoCountLabel.text
        }
    }

    static let identifier = "UserViewCell"
}
