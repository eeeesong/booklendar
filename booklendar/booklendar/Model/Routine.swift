//
//  Routine.swift
//  booklendar
//
//  Created by Song on 2021/09/23.
//

import Foundation

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
