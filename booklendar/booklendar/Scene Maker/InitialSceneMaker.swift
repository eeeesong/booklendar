//
//  InitialSceneMaker.swift
//  booklendar
//
//  Created by Song on 2021/10/17.
//

import UIKit

final class InitialSceneMaker {
    func create(with info: [String: Routine]) -> UIViewController {
        var calendarViewController = CalendarViewController()
        let navigationController = UINavigationController(rootViewController: calendarViewController)
        let calendarManager = CalendarManager(routines: info)
        let pushCoordinator = DetailPushCoordinator(navigationController: navigationController)
        let sceneMaker = DetailSceneMaker(calendarManaer: calendarManager, navigationController: navigationController)
        let calendarViewModel = CalendarViewModel(calendarManager: calendarManager,
                                                  pushCoordinator: pushCoordinator,
                                                  sceneMaker: sceneMaker)
        calendarViewController.set(calendarViewModel)
        return navigationController
    }
}
