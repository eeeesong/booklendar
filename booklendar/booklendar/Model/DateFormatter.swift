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
    static let fullDate = "YYYY. M. d"
}

extension Date {
    func dateToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension DateFormatter {
    static func dateToString(format: String, date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // 개선 필요한 거지같은 메소드
    static func transformMonthToEnglish(_ original: String) -> String {
        let monthsInEnglish = ["January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        let strings = original.split(separator: " ").map { String($0) }
        let month = strings[0].dropLast()
        let index = Int(month)! - 1
        return monthsInEnglish[index] + " " + strings[1]
    }
}
