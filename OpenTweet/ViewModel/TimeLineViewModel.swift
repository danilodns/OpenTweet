//
//  TimeLineViewModel.swift
//  OpenTweet
//
//  Created by Danilo Silveira on 2024-07-24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

protocol TimeLineProtocol {
    func reloadContent()
}

class TimeLineViewModel {
    private var timelineTweets: [Tweet]
    private var timelineProtocol : TimeLineProtocol?
    
    init(timelineTweets: [Tweet] = [], timelineProtocol: TimeLineProtocol? = nil) {
        self.timelineTweets = timelineTweets
        self.timelineProtocol = timelineProtocol
    }
    
    func setProtocol(timelineProtocol: TimeLineProtocol) {
        self.timelineProtocol = timelineProtocol
    }
    
    func getTimeLineTweetCounts() -> Int {
        timelineTweets.count
    }
    
    func getTweet(for index: Int) -> Tweet {
        timelineTweets[index]
    }
    
    func getTweetThread(for index: Int) -> [Tweet] {
        //get all tweets replies from one specific tweet along with tapped tweet and the tweet it's replying to
        let tweet = getTweet(for: index)
        return timelineTweets.filter({ $0.inReplyTo == tweet.id || $0.id == tweet.id || $0.id == tweet.inReplyTo})
    }
    
    func fetchTimelineFromJson() {
        if timelineTweets.count > 0 {
            
        } else {
            do {
                guard let path = Bundle.main.path(forResource: "timeline", ofType: "json"),
                      let data = try String(contentsOfFile: path).data(using: .utf8) else { return }
                let decoder = JSONDecoder()
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withFullDate]

                decoder.dateDecodingStrategy = .custom({ decoder in
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self)
                    
                    if let date = formatter.date(from: dateString) {
                        return date
                    }
                    
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
                })
                
                // Decoding data for the Tweet Model
                let timeLine = try decoder.decode([String:[Tweet]].self, from: data)
                
                // Sorting in ascending order and trigger the protocol to reload the table
                timelineTweets = timeLine["timeline"]?.sorted(by: { $0.date < $1.date}) ?? []
                self.timelineProtocol?.reloadContent()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
