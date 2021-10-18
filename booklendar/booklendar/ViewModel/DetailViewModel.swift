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
    func editingFinished()
}

final class DetailViewModel: DetailViewModelType {
    
    typealias DetailPopCoordinator = CommonPopCoordinator<Bool>
    private(set) var dayRecord: DayRecord
    private var popCoordinator: DetailPopCoordinator
    private var viewNeedsUpdate = false
    
    init(currentRecord: DayRecord, popCoordinator: DetailPopCoordinator) {
        self.dayRecord = currentRecord
        self.popCoordinator = popCoordinator
    }
    
    func initialData() -> DayRecord {
        return dayRecord
    }
    
    func newBookSelected(_ book: Book) {
        let newRecord = Record(order: 0, book: book, comment: "")
        dayRecord.record = newRecord
        viewNeedsUpdate = true
    }
    
    func newCommentAdded(_ comment: String) {
        dayRecord.record?.comment = comment
        viewNeedsUpdate = true
    }
    
    func editingFinished() {
        popCoordinator.pop(with: viewNeedsUpdate)
    }
}
