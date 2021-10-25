//
//  SearchSceneMaker.swift
//  booklendar
//
//  Created by Song on 2021/10/24.
//

import UIKit

final class SearchSceneMaker {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func create(with info: [Book]) -> SearchViewController {
        var searchViewController = SearchViewController()
        let viewModel = SearchViewModel()
        searchViewController.set(viewModel)
        return searchViewController
    }
}
