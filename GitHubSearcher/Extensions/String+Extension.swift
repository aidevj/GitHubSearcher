//
//  String+Extension.swift
//  GitHubSearcher
//
//  Created by Consultant on 4/12/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

extension String {
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "yyyy MMM HH:mm EEEE"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }

}
