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
    
    private var calendarManager = CalendarManager(routines: [:])
    
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
