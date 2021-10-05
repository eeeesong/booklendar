//
//  DateFormatter.swift
//  booklendar
//
//  Created by Song on 2021/09/23.
//

import Foundation

enum DateFormat {
    static let dateKey = "YYYYMMDD"
    static let onlyDay = "d"
    static let monthYear = "M월 YYYY"
}

extension DateFormatter {
    static func dateToString(format: String, date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
