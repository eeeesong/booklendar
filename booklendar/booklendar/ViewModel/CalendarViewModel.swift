//
//  CalendarViewModel.swift
//  booklendar
//
//  Created by Song on 2021/10/04.
//

import Foundation

protocol CalendarViewModelType {
    func initialData(of initialCount: Int) -> [[DayRecord]]
    func newCalendarNeeded() -> [DayRecord]
}

final class CalendarViewModel: CalendarViewModelType {
    
    private var calendarManager: CalendarManagable
    
    init(calendarManager: CalendarManagable) {
        self.calendarManager = calendarManager
    }
    
    func initialData(of initialCount: Int) -> [[DayRecord]] {
        var initialData = [[DayRecord]]()
        
        for _ in 1...initialCount {
            let newMonth = calendarManager.loadLastData()
            initialData.append(newMonth)
        }
        return initialData
    }
    
    func newCalendarNeeded() -> [DayRecord] {
        calendarManager.loadLastData()
    }
}
