//
//  UserViewCell.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class UserPreviewViewCell: UITableViewCell {

    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repoCountLabel: UILabel!

    var user: User! {
        didSet {
            if let avatarAsUrl = URL(string: user.avatarURL!) {
                userAvatarImage.load(url: avatarAsUrl)
            }

            usernameLabel.text = user.username
            repoCountLabel.text = "Repos: \(user.reposCount ?? 0)"
        }
    }

    static let identifier = "UserPreviewViewCell"
}
