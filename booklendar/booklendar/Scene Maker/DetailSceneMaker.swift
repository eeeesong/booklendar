//
//  DetailSceneMaker.swift
//  booklendar
//
//  Created by Song on 2021/10/17.
//

import UIKit

final class DetailSceneMaker {
    private let calendarManager: CalendarManagable
    
    init(calendarManaer: CalendarManagable) {
        self.calendarManager = calendarManaer
    }
    
    func create(with info: Routine?) -> DetailViewController {
        var detailViewController = DetailViewController()
        let tempRecord = DayRecord(day: Day(isFuture: false, date: Date(), isEmpty: false),
                                   record: Record(order: 0, book: Book(recentlyAdded: Date(), id: "", coverUrl: "", title: "SAVAGE", authors: ["에스파","이수만"], translators: [], publisher: "", page: 400), comment: "oh my gosh~"))
        let viewModel = DetailViewModel(currentRecord: tempRecord)
        detailViewController.set(viewModel)
        return detailViewController
    }
}
