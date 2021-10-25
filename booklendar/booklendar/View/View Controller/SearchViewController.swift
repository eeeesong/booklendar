//
//  SearchViewController.swift
//  booklendar
//
//  Created by Song on 2021/10/24.
//

import UIKit

final class SearchViewController: UIViewController, ViewModelIncludable {
    var viewModel: SearchViewModel?
    typealias ViewModel = SearchViewModel
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
}
