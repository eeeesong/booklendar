//
//  DetailDataSource.swift
//  booklendar
//
//  Created by Song on 2021/10/15.
//

import UIKit

final class DetailCollectionViewDataSource: NSObject {
    private(set) var dateString: String
    private(set) var record: Record?
    
    required init(dayRecord: DayRecord?) {
        let date = dayRecord?.day.date
        self.dateString = DateFormatter.dateToString(format: DateFormat.dateKey, date: date)
        self.record = dayRecord?.record
        super.init()
    }
}

extension DetailCollectionViewDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // 추후 코멘트 표시에 따라 변경
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = CommentCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CommentCollectionViewCell ?? CommentCollectionViewCell()
        let comment = record?.comment ?? ""
        let commentInfo = CommentInfo(date: dateString, body: comment)
        cell.configure(with: commentInfo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerId = DetailHeaderCollectionViewCell.identifier
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? DetailHeaderCollectionViewCell ?? DetailHeaderCollectionViewCell()
            header.configure(with: dateString, record?.book)
            return header
        default:
            assert(false)
        }
    }
}