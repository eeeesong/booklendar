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
    func calendarCellSelected(at indexPath: IndexPath, dayRecord: DayRecord)
    func new(routine: Routine)
}

final class CalendarViewModel: CalendarViewModelType {
    
    private var calendarManager: CalendarManagable
    private var pushCoordinator: DetailPushCoordinator
    private var sceneMaker: DetailSceneMaker
    
    init(calendarManager: CalendarManagable, pushCoordinator: DetailPushCoordinator, sceneMaker: DetailSceneMaker) {
        self.calendarManager = calendarManager
        self.pushCoordinator = pushCoordinator
        self.sceneMaker = sceneMaker
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
    
    func calendarCellSelected(at indexPath: IndexPath, dayRecord: DayRecord) {
        guard let date = dayRecord.day.date else { return }
        let dateKey = date.dateToString(format: DateFormat.dateKey)
        let targetInfo = calendarManager.routine(for: dateKey) ?? Routine(date: date)
        pushCoordinator.push(with: targetInfo, sceneMaker: sceneMaker(info:))
    }
    
    private func sceneMaker(info: Routine) -> DetailViewController {
        return sceneMaker.create(with: info)
    }
    
    func new(routine: Routine) {
        calendarManager.update(from: routine)
    }
}
