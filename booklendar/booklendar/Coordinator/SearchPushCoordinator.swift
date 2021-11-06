//
//  SearchPushCoordinator.swift
//  booklendar
//
//  Created by Song on 2021/10/24.
//

import UIKit

final class SearchPushCoordinator: PushCoordinator {
    
    typealias Info = [Book]
    typealias Target = SearchViewController
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(with info: [Book], sceneMaker: SceneMaker) {
        let searchViewController = sceneMaker(info)
        navigationController.pushViewController(searchViewController, animated: true)
    }
}
