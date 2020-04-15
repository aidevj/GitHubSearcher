//
//  String+Extension.swift
//  GitHubSearcher
//
//  Created by Aiden Melendez on 4/12/20.
//  Copyright © 2020. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let makeDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }()
    static let makeStringFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter
    }()
}

extension String {
    func toDate() -> Date? {
        DateFormatter.makeDateFormatter.date(from: self)
    }
}
extension Date {
    func toString() -> String {
        DateFormatter.makeStringFormatter.string(from: self)
    }

}
