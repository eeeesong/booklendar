//
//  Record.swift
//  booklendar
//
//  Created by Song on 2021/09/22.
//

import Foundation

struct Record {
    var order: Int
    var frameStyle: FramedImageView.Style
    var book: Book
    var comment: String
}

extension Record: Comparable {
    static func < (lhs: Record, rhs: Record) -> Bool {
        return lhs.order < rhs.order
    }
    
    static func == (lhs: Record, rhs: Record) -> Bool {
        return lhs.book.id == rhs.book.id
    }
}

struct Book {
    var recentlyAdded: Date
    let id: String
    let coverUrl: String
    let title: String
    let authors: [String]
    let translators: [String]
    let publisher: String
    let page: Int
}
