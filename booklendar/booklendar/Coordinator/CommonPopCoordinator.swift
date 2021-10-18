//
//  CommonPopCoordinator.swift
//  booklendar
//
//  Created by Song on 2021/10/18.
//

import UIKit

final class CommonPopCoordinator<State>: PopCoordinator {
    
    typealias State = State
    private var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pop(with state: State) {
        navigationController.popViewController(animated: true)
        guard let topViewController = navigationController.topViewController as? NewStateAcceptable else { return }
        topViewController.accept(newState: state)
    }
}
