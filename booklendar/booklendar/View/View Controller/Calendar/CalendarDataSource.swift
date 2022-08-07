//
//  CalendarDataSource.swift
//  booklendar
//
//  Created by Song on 2021/09/28.
//

import UIKit

final class CalendarDataSource: NSObject {
    private(set) var sections = [[DayRecord]]()
    
    func new(month: [DayRecord]) {
        sections.append(month)
    }
}

extension CalendarDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = MonthlyCalendarCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MonthlyCalendarCollectionViewCell ?? MonthlyCalendarCollectionViewCell()
        cell.configure(with: sections[indexPath.section][indexPath.row].day, "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerId = CalendarHeaderCollectionViewCell.identifier
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? CalendarHeaderCollectionViewCell ?? CalendarHeaderCollectionViewCell()
            let midDay = sections[indexPath.section][15].day
            let monthInfo = DateFormatter.dateToString(format: DateFormat.monthYear, date: midDay.date)
            let monthInfoInEnglish = DateFormatter.transformMonthToEnglish(monthInfo)
            let headerInfo = HeaderInfo.month(monthInfoInEnglish)
            header.configure(with: headerInfo)
            return header
        default:
            assert(false)
        }
    }
}
