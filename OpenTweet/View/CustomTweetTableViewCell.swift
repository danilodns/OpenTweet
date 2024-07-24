//
//  CustomTweetTableViewCell.swift
//  OpenTweet
//
//  Created by Danilo Silveira on 2024-07-24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit
import SDWebImage

class CustomTweetTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetContentTextview: UITextView!
    
    @IBOutlet weak var bottomTweetConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetContentTextview.textContainerInset = .zero
    }
    
    override func prepareForReuse() {
        self.avatarImageView.sd_cancelCurrentImageLoad()
    }

    func configure(tweet: Tweet) {
        usernameLabel.text = tweet.author
        dateLabel.text = tweet.date.toString()
        tweetContentTextview.isUserInteractionEnabled = true
        avatarImageView.sd_setImage(with: URL(string: tweet.avatar ?? ""), placeholderImage: UIImage(systemName: "person"))
        tweetContentTextview.text = tweet.content
    }
    
}
