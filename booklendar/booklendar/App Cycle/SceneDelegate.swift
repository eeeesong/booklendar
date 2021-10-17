//
//  SceneDelegate.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        var calendarViewController = CalendarViewController()
        let navigationController = UINavigationController(rootViewController: calendarViewController)
        let calendarManager = CalendarManager(routines: [:])
        let pushCoordinator = DetailPushCoordinator(navigationController: navigationController)
        let sceneMaker = DetailSceneMaker()
        let calendarViewModel = CalendarViewModel(calendarManager: calendarManager, pushCoordinator: pushCoordinator, sceneMaker: sceneMaker)
        calendarViewController.set(calendarViewModel)
        window?.rootViewController = navigationController
    }
}
