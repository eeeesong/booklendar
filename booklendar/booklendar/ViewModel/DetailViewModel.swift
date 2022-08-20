//
//  DetailViewModel.swift
//  booklendar
//
//  Created by Song on 2021/10/15.
//

import Foundation

protocol DetailViewModelType {
    var updator: ((Routine) -> ()) { get set }
    func initialData() -> Routine
    func searchStarted()
    func newBookSelected(_ book: Book?)
    func newCommentAdded(_ comment: String)
    func newStyleSelected(_ style: FramedImageView.Style)
    func editStateChanged(to state: DetailEditState)
    func editingFinished()
}

enum DetailEditState {
    case doing
    case done
}

final class DetailViewModel: DetailViewModelType {
    
    typealias DetailPopCoordinator = CommonPopCoordinator<Routine?>
    private var currentDetails: Routine
    private var popCoordinator: DetailPopCoordinator
    private var searchPushCoordinator: SearchPushCoordinator
    private var searchSceneMaker: SearchSceneMaker
    private var viewNeedsUpdate: Routine?
    var updator: ((Routine) -> ())
    
    init(currentDetails: Routine, popCoordinator: DetailPopCoordinator, searchPushCoordinator: SearchPushCoordinator, searchSceneMaker: SearchSceneMaker, updator: @escaping ((Routine) -> ())) {
        self.currentDetails = currentDetails
        self.popCoordinator = popCoordinator
        self.searchPushCoordinator = searchPushCoordinator
        self.searchSceneMaker = searchSceneMaker
        self.updator = updator
    }
    
    func initialData() -> Routine {
        return currentDetails
    }
    
    func searchStarted() {
        // 여기서 최근 검색 결과를 보여준다...ㅎ
        let tempBooks =
        [
            Book(recentlyAdded: Date(), id: "", coverUrl: "https://pbs.twimg.com/profile_images/1445377282189578243/X_1X9b5W_400x400.jpg", title: "낮밤", authors: ["이영지", "박재범"], translators: [], publisher: "영쥐", page: 40),
            Book(recentlyAdded: Date(), id: "", coverUrl: "https://images.genius.com/5ce3a54c776805519c3bf039010528df.1000x1000x1.jpg", title: "Attention", authors: ["뉴진스"], translators: [], publisher: "민희진", page: 40),
            Book(recentlyAdded: Date(), id: "", coverUrl: "https://blog.kakaocdn.net/dn/DzIKp/btrH1a0ynbr/0KFwD8kKJPrCz0e5ZkLH21/img.jpg", title: "Hype boy", authors: ["뉴진스"], translators: [], publisher: "민희진", page: 40)
        ]
        searchPushCoordinator.push(with: tempBooks, sceneMaker: searchSceneMaker.create, completionHandler: newBookSelected(_:))
    }
    
    func newBookSelected(_ book: Book?) {
        guard let book = book else { return }
        var newRecord = Record(order: 0, frameStyle: .random(), book: book, comment: "")
        if !currentDetails.records.isEmpty {
            let currentRecord = currentDetails.records[0]
            newRecord.comment = currentRecord.comment
            newRecord.frameStyle = currentRecord.frameStyle
        }
        currentDetails.records.insert(newRecord, at: 0)
        updator(currentDetails)
        viewNeedsUpdate = currentDetails
    }
    
    func newCommentAdded(_ comment: String) {
        guard !currentDetails.records.isEmpty else { return }
        currentDetails.records[0].comment = comment
        viewNeedsUpdate = currentDetails
    }
    
    func newStyleSelected(_ style: FramedImageView.Style) {
        guard !currentDetails.records.isEmpty else { return }
        currentDetails.records[0].frameStyle = style
        viewNeedsUpdate = currentDetails
    }
    
    func editStateChanged(to state: DetailEditState) {

    }
    
    func editingFinished() {
        popCoordinator.pop(with: viewNeedsUpdate)
    }
}
