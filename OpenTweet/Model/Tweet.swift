//
//  Tweet.swift
//  OpenTweet
//
//  Created by Danilo Silveira on 2024-07-24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

struct Tweet: Codable {
    var id: String
    var author: String
    var content: String
    var date: Date
    var avatar: String?
    var inReplyTo: String?
}
