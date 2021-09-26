//
//  Month.swift
//  booklendar
//
//  Created by Song on 2021/09/23.
//

import Foundation

struct DayRecord {
    let day: Day
    var record: Record?
}

struct Day {
    var isFuture: Bool
    let date: Date?
    let isEmpty: Bool
}
