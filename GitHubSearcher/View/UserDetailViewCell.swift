//
//  DetailViewCell.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/10/20.
//  Copyright © 2020. All rights reserved.
//
import UIKit

class UserDetailViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!

    static let identifier = "DetailViewCell"

    var user: User! {
        didSet {
            if let avatarAsUrl = URL(string: user.avatarURL!) {
                avatarImageView.load(url: avatarAsUrl)
            }

            usernameLabel.text = user.username
            emailLabel.text = user.email
            locationLabel.text = user.location
            joinDateLabel.text = user.joinDate
            followersCountLabel.text = user.followerCount?.toString()
            followingCountLabel.text = user.followingCount?.toString()
        }
    }
}
