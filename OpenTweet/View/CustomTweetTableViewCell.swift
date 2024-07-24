//
//  CustomTweetTableViewCell.swift
//  OpenTweet
//
//  Created by Danilo Silveira on 2024-07-24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import UIKit

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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
