//
//  DateFormatter.swift
//  booklendar
//
//  Created by Song on 2021/09/23.
//

import Foundation

enum DateFormat {
    static let dateKey = "YYYYMMDD"
}

extension DateFormatter {
    static func dateToString(format: String, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
