//
//  DetailViewModel.swift
//  booklendar
//
//  Created by Song on 2021/10/15.
//

import Foundation

protocol DetailViewModelType {
    func initialData() -> Routine
    func searchStarted()
    func newBookSelected(_ book: Book)
    func newCommentAdded(_ comment: String)
    func editStateChanged(to state: DetailEditState)
    func editingFinished()
}

enum DetailEditState {
    case doing
    case done
}

final class DetailViewModel: DetailViewModelType {
    
    typealias DetailPopCoordinator = CommonPopCoordinator<Bool>
    private var currentDetails: Routine
    private var popCoordinator: DetailPopCoordinator
    private var searchPushCoordinator: SearchPushCoordinator
    private var searchSceneMaker: SearchSceneMaker
    private var viewNeedsUpdate = false
    
    init(currentDetails: Routine, popCoordinator: DetailPopCoordinator, searchPushCoordinator: SearchPushCoordinator, searchSceneMaker: SearchSceneMaker) {
        self.currentDetails = currentDetails
        self.popCoordinator = popCoordinator
        self.searchPushCoordinator = searchPushCoordinator
        self.searchSceneMaker = searchSceneMaker
    }
    
    func initialData() -> Routine {
        return currentDetails
    }
    
    func searchStarted() {
        searchPushCoordinator.push(with: [], sceneMaker: searchSceneMaker.create)
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
    
    func editStateChanged(to state: DetailEditState) {

    }
    
    func editingFinished() {
        popCoordinator.pop(with: viewNeedsUpdate)
    }
}
