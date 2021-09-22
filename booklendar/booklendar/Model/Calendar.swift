//
//  Calendar.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import Foundation

class Calendar {
    private var days: [Int: Day]
    
    init(days: [Int: Day]) {
        self.days = days
    }
    
    func mainBook(for dateKey: Int) -> Record? {
        guard let day = days[dateKey] else {
            return nil
        }
        return day.main()
    }
    
    func allBooks(for dateKey: Int) -> [Record]? {
        guard let day = days[dateKey] else {
            return nil
        }
        return day.all()
    }
}

class Day {
    let date: Date
    var records: [Record]
    
    init(date: Date, records: [Record]) {
        self.date = date
        self.records = records
    }
    
    func main() -> Record {
        return records.min()!
    }
    
    func all() -> [Record] {
        records.sort()
        return records
    }
}
