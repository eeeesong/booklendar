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
    
    func create(with info: Routine) -> DetailViewController {
        var detailViewController = DetailViewController()
        let popCoordinator = CommonPopCoordinator<Routine?>(navigationController: navigationController)
        let searchPushCordinator = SearchPushCoordinator(navigationController: navigationController)
        let searchSceneMaker = SearchSceneMaker(navigationController: navigationController)
        let viewModel = DetailViewModel(currentDetails: info,
                                        popCoordinator: popCoordinator,
                                        searchPushCoordinator: searchPushCordinator,
                                        searchSceneMaker: searchSceneMaker,
                                        updator: detailViewController.redraw(with:))
        detailViewController.set(viewModel)
        return detailViewController
    }
}
