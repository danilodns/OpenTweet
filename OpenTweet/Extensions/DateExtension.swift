//
//  DateExtension.swift
//  OpenTweet
//
//  Created by Danilo Silveira on 2024-07-24.
//  Copyright © 2024 OpenTable, Inc. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(dateFormat: String = "MM-d-y") -> String {
        let formarter = DateFormatter()
        formarter.dateFormat = dateFormat
        return formarter.string(from: self)
    }
}
