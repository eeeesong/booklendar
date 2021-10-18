//
//  DetailViewModel.swift
//  booklendar
//
//  Created by Song on 2021/10/15.
//

import Foundation

protocol DetailViewModelType {
    func initialData() -> Routine
    func newBookSelected(_ book: Book)
    func newCommentAdded(_ comment: String)
    func editingFinished()
}

final class DetailViewModel: DetailViewModelType {
    
    typealias DetailPopCoordinator = CommonPopCoordinator<Bool>
    private var currentDetails: Routine
    private var popCoordinator: DetailPopCoordinator
    private var viewNeedsUpdate = false
    
    init(currentDetails: Routine, popCoordinator: DetailPopCoordinator) {
        self.currentDetails = currentDetails
        self.popCoordinator = popCoordinator
    }
    
    func initialData() -> Routine {
        return currentDetails
    }
    
    func newBookSelected(_ book: Book) {
        let newRecord = Record(order: 0, book: book, comment: "")
        currentDetails.records.append(newRecord)
        viewNeedsUpdate = true
    }
    
    func newCommentAdded(_ comment: String) {
        currentDetails.records[0].comment = comment
        viewNeedsUpdate = true
    }
    
    func editingFinished() {
        popCoordinator.pop(with: viewNeedsUpdate)
    }
}
