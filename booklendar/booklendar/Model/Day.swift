//
//  Month.swift
//  booklendar
//
//  Created by Song on 2021/09/23.
//

import Foundation

class DayRecord: Equatable {
    let day: Day
    var record: Record?
    
    init(day: Day, record: Record?) {
        self.day = day
        self.record = record
    }
    
    static func == (lhs: DayRecord, rhs: DayRecord) -> Bool {
        return lhs.day.date == rhs.day.date
    }
}

struct Day {
    var isFuture: Bool
    let date: Date?
    let isEmpty: Bool
}
