//
//  SearchViewController.swift
//  booklendar
//
//  Created by Song on 2021/10/24.
//

import UIKit

final class SearchViewController: UIViewController, ViewModelIncludable {
    
    // View
    private var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        return searchController
    }()
    
    private var bookTableView: BookTableView = {
        let tableView = BookTableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // View Model
    var viewModel: SearchViewModel?
    typealias ViewModel = SearchViewModel
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false 
        addBookTableView()
    }
    
    private func addBookTableView() {
        view.addSubview(bookTableView)
        
        NSLayoutConstraint.activate([
            bookTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bookTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
