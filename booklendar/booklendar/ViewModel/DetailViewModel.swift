//
//  DetailViewModel.swift
//  booklendar
//
//  Created by Song on 2021/10/15.
//

import Foundation

protocol DetailViewModelType {
    func initialData() -> DayRecord
    func newBookSelected(_ book: Book)
    func newCommentAdded(_ comment: String)
}

final class DetailViewModel: DetailViewModelType {
    
    private(set) var dayRecord: DayRecord
    
    init(currentRecord: DayRecord) {
        self.dayRecord = currentRecord
    }
    
    func initialData() -> DayRecord {
        return dayRecord
    }
    
    func newBookSelected(_ book: Book) {
        let newRecord = Record(order: 0, book: book, comment: "")
        dayRecord.record = newRecord
    }
    
    func newCommentAdded(_ comment: String) {
        dayRecord.record?.comment = comment
    }
}
