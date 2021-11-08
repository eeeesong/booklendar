//
//  BookTableViewDataSource.swift
//  booklendar
//
//  Created by Song on 2021/11/01.
//

import UIKit

final class BookTableViewDataSource: NSObject {
    private(set) var books: [Book]
    
    required init(books: [Book] = []) {
        self.books = books
        super.init()
    }
    
    func new(books: [Book]) {
        self.books = books
    }
}

extension BookTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = BookTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? BookTableViewCell ?? BookTableViewCell()
        let targetBook = books[indexPath.row]
        cell.configure(with: targetBook)
        return cell
    }
}
