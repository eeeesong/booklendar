//
//  CalendarViewModel.swift
//  booklendar
//
//  Created by Song on 2021/10/04.
//

import Foundation

protocol CalendarViewModelType {
    func newCalendarNeeded() -> [DayRecord]
}

final class CalendarViewModel: CalendarViewModelType {
    
    private var calendarManager = CalendarManager(routines: [:])
    
    func newCalendarNeeded() -> [DayRecord] {
        calendarManager.loadData(including: Date())
    }
}
