//
//  CalendarDataSource.swift
//  booklendar
//
//  Created by Song on 2021/09/28.
//

import UIKit

final class CalendarDataSource: NSObject {
    private let sections = [30, 31, 29, 28, 35]
}

extension CalendarDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = MontlyCalendarCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MontlyCalendarCollectionViewCell ?? MontlyCalendarCollectionViewCell()
        cell.configure(with: "\(Int.random(in: 1...31))", "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerId = CalendarHeaderCollectionViewCell.identifier
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? CalendarHeaderCollectionViewCell ?? CalendarHeaderCollectionViewCell()
            let headerInfo = HeaderInfo.month("September 2021")
            header.configure(with: headerInfo)
            return header
        default:
            assert(false)
        }
    }
}
