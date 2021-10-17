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
    func calendarCellSelected(at indexPath: IndexPath)
}

final class CalendarViewModel: CalendarViewModelType {
    
    typealias State = Routine?
    private var calendarManager: CalendarManagable
    private var pushCoordinator: DetailPushCoordinator
    
    init(calendarManager: CalendarManagable, pushCoordinator: DetailPushCoordinator) {
        self.calendarManager = calendarManager
        self.pushCoordinator = pushCoordinator
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
    
    func calendarCellSelected(at indexPath: IndexPath) {
        let month = indexPath.section
        let day = indexPath.row
        let targetInfo = calendarManager.allRecords(at: month, day)
        pushCoordinator.push(with: targetInfo, sceneMaker: sceneMaker(info:))
    }
    
    func sceneMaker(info: Routine?) -> DetailViewController {
        var detailViewController = DetailViewController()
        let tempRecord = DayRecord(day: Day(isFuture: false, date: Date(), isEmpty: false),
                                   record: Record(order: 0, book: Book(recentlyAdded: Date(), id: "", coverUrl: "", title: "SAVAGE", authors: ["에스파","이수만"], translators: [], publisher: "", page: 400), comment: "oh my gosh~"))
        let viewModel = DetailViewModel(currentRecord: tempRecord)
        detailViewController.set(viewModel)
        return detailViewController
    }
}
