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
        // stop the download in case the image go off screen
        self.avatarImageView.sd_cancelCurrentImageLoad()
        bottomTweetConstraint.constant = 5
    }

    func configure(tweet: Tweet, isSelected: Bool = false) {
        usernameLabel.text = tweet.author
        dateLabel.text = tweet.date.toString()
        tweetContentTextview.isUserInteractionEnabled = isSelected
        //loading using SDWebImage to cache the image after the download
        avatarImageView.sd_setImage(with: URL(string: tweet.avatar ?? ""), placeholderImage: UIImage(systemName: "person"))
        //Highlight the mentions (@username)
        let tweetContent = (tweet.content as NSString)
        let usernameHighlight = tweetContent.range(of: "@\\w.*?\\b", options: .regularExpression, range: NSMakeRange(0, tweetContent.length))
        let attTweet = NSMutableAttributedString(string: tweet.content, attributes: [
                .font: UIFont.systemFont(ofSize: isSelected ? 20 : 16),
                .foregroundColor: isSelected ? UIColor.red : UIColor.black])
            attTweet.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: usernameHighlight)
            tweetContentTextview.attributedText = attTweet
        if isSelected {
            bottomTweetConstraint.constant = 50
        }
        
    }
    
}
