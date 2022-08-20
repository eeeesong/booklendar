//
//  DetailPushCoordinator.swift
//  booklendar
//
//  Created by Song on 2021/10/17.
//

import UIKit

final class DetailPushCoordinator: PushCoordinator {

    typealias Info = Routine
    typealias Target = DetailViewController
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(with info: Info, sceneMaker: SceneMaker, completionHandler: ((Info?) -> ())? = nil) {
        let detailViewController = sceneMaker(info)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
