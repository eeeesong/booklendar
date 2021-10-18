//
//  SceneDelegate.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let initialSceneMaker = InitialSceneMaker()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let savedDate = [String: Routine]()
        window?.rootViewController = initialSceneMaker.create(with: savedDate)
    }
}
