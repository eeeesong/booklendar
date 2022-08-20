//
//  SearchViewController.swift
//  booklendar
//
//  Created by Song on 2021/10/24.
//

import UIKit

final class SearchViewController: UIViewController, ViewModelIncludable {
    
    // View
    private var searchResultController = SearchResultController()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        return searchController
    }()
    
    private lazy var bookTableView: BookTableView = {
        let tableView = BookTableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // View Helpers
    private var bookTableViewDelegate: BookTableViewDelegate?
    private var bookTableViewDataSource: BookTableViewDataSource?
    
    // View Model
    var viewModel: SearchViewModel?
    typealias ViewModel = SearchViewModel
    var completionHandler: ((Book?) -> ())?
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBookTableViewHelpers()
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
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
    
    private func setBookTableViewHelpers() {
        bookTableViewDelegate = BookTableViewDelegate(actionHandler: viewNeedsChanges)
        bookTableView.delegate = bookTableViewDelegate
        bookTableViewDataSource = BookTableViewDataSource(books: viewModel?.initialData() ?? [])
        bookTableView.dataSource = bookTableViewDataSource
    }
    
    func viewNeedsChanges(with action: BookTableAction) {
        switch action {
        case .selectedAt(let indexPath):
            let selectedBook = viewModel?.resultSelected(at: indexPath)
            completionHandler?(selectedBook)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else { return }
        let newResult = viewModel?.startSearch(for: keyword) ?? []
        searchResultController.newSearchResult(newResult)
    }
}
