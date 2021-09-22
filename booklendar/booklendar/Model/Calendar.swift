//
//  Calendar.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import Foundation

class Calendar {
    private var routines: [Int: Routine]
    
    init(days: [Int: Routine]) {
        self.routines = days
    }
    
    func mainBook(for dateKey: Int) -> Record? {
        guard let day = routines[dateKey] else {
            return nil
        }
        return day.main()
    }
    
    func allBooks(for dateKey: Int) -> [Record]? {
        guard let day = routines[dateKey] else {
            return nil
        }
        return day.all()
    }
}

class Routine {
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
