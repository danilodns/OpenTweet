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
    private var timelineTweets: [Tweet] = []
    private var timelineProtocol : TimeLineProtocol?
    
    func setProtocol(timelineProtocol: TimeLineProtocol) {
        self.timelineProtocol = timelineProtocol
    }
    
    func getTimeLineTweetCounts() -> Int {
        timelineTweets.count
    }
    
    func getTweet(for Index: Int) -> Tweet {
        timelineTweets[Index]
    }
    
    func fetchTimelineFromJson() {
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
