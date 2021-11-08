//
//  SearchViewModel.swift
//  booklendar
//
//  Created by Song on 2021/10/24.
//

import Foundation

protocol SearchViewModelType {
    func initialData() -> [Book]
    func startSearch(for keyword: String) -> [Book]
    func resultSelected(at indexPath: IndexPath)
}


final class SearchViewModel: SearchViewModelType {
    
    private var isSearchOn: Bool
    private let recentBooks: [Book]
    private var searchedBooks: [Book]
    
    init(recentBooks: [Book]) {
        isSearchOn = false
        self.recentBooks = recentBooks
        searchedBooks = [Book]()
    }
    
    func initialData() -> [Book] {
        return recentBooks
    }
    
    func startSearch(for keyword: String) -> [Book] {
        guard keyword.count > 0 else {
            isSearchOn = false
            return recentBooks
        }
        
        isSearchOn = true
        let tempBook = Book(recentlyAdded: Date(), id: "", coverUrl: "", title: keyword, authors: [keyword], translators: [], publisher: "", page: 30)
        searchedBooks = Array(repeating: tempBook, count: keyword.count)
        return searchedBooks
        // 네트워크 레이어를 통해 검색 실행
    }
    
    func resultSelected(at indexPath: IndexPath) {
        let index = indexPath.row
        let targetBook = isSearchOn ? searchedBooks[index] : recentBooks[index]
        print(targetBook.title) // 이전 화면에 정보를 넘김
    }
}
