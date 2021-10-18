//
//  DetailSceneMaker.swift
//  booklendar
//
//  Created by Song on 2021/10/17.
//

import UIKit

final class DetailSceneMaker {
    private let calendarManager: CalendarManagable
    private var navigationController: UINavigationController
    
    init(calendarManaer: CalendarManagable, navigationController: UINavigationController) {
        self.calendarManager = calendarManaer
        self.navigationController = navigationController
    }
    
    func create(with info: Routine?) -> DetailViewController {
        var detailViewController = DetailViewController()
        let tempRecord = Record(order: 0, book: Book(recentlyAdded: Date(), id: "", coverUrl: "", title: "SAVAGE", authors: ["에스파","이수만"], translators: [], publisher: "", page: 400), comment: "하하하")
        let tempRoutine = Routine(date: Date(), records: [tempRecord, tempRecord])
        let popCoordinator = CommonPopCoordinator<Bool>(navigationController: navigationController)
        let viewModel = DetailViewModel(currentDetails: tempRoutine, popCoordinator: popCoordinator)
        detailViewController.set(viewModel)
        return detailViewController
    }
}
