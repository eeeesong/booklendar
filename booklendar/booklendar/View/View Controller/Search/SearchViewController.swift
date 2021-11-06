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
        
        let tempBooks = [Book(recentlyAdded: Date(), id: "", coverUrl: "", title: "낮밤", authors: ["이영지", "박재범"], translators: [], publisher: "영쥐", page: 40)]
        bookTableViewDataSource = BookTableViewDataSource(books: tempBooks)
        bookTableView.dataSource = bookTableViewDataSource
    }
    
    func viewNeedsChanges(with action: BookTableAction) {
        print("뒤로 가기")
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else { return }
        print(keyword)
    }
}
