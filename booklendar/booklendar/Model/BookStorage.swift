//
//  BookStorage.swift
//  booklendar
//
//  Created by Song on 2021/09/22.
//

import Foundation

class BookStorage {
    static let shared = BookStorage()
    
    private var books: [Book]
    
    private init(books: [Book] = []) {
        self.books = books
    }
    
    func recent(_ count: Int) -> [Book] {
        let realCount = min(books.count, count)
        return Array(books[0..<realCount])
    }
    
    @discardableResult
    func add(newBook: Book) -> Bool {
        for index in 0..<books.count {
            if books[index].id == newBook.id {
                books[index].recentlyAdded = newBook.recentlyAdded
                return false
            }
        }
        books.append(newBook)
        return true
    }
    
    func configure(with books: [Book]) {
        self.books = books
    }
}
