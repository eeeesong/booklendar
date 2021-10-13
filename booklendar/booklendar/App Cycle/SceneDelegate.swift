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
        let calendarViewController = CalendarViewController()
        let navigationController = UINavigationController(rootViewController: calendarViewController)
        window?.rootViewController = navigationController
    }
}
