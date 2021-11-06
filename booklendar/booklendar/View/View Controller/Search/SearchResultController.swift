//
//  SearchResultController.swift
//  booklendar
//
//  Created by Song on 2021/11/06.
//

import UIKit

final class SearchResultController: UIViewController {

    // View
    private var resultTableView: BookTableView = {
        let tableView = BookTableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // View Helpers
    private var bookTableViewDelegate: BookTableViewDelegate?
    private var bookTableViewDataSource: BookTableViewDataSource?
    
    override func loadView() {
        super.loadView()
        addTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBookTableViewHelpers()
    }
    
    private func addTableView() {
        view.addSubview(resultTableView)
        
        NSLayoutConstraint.activate([
            resultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            resultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            resultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setBookTableViewHelpers() {
        bookTableViewDelegate = BookTableViewDelegate(actionHandler: viewNeedsChanges)
        resultTableView.delegate = bookTableViewDelegate
        
        let tempBooks = [Book(recentlyAdded: Date(), id: "", coverUrl: "", title: "밤낮", authors: ["이영지", "박재범"], translators: [], publisher: "영쥐", page: 40)]
        bookTableViewDataSource = BookTableViewDataSource(books: tempBooks)
        resultTableView.dataSource = bookTableViewDataSource
    }
    
    func viewNeedsChanges(with action: BookTableAction) {
        print("책 선택했다")
    }
}
