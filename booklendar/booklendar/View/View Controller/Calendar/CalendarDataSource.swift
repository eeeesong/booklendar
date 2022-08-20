//
//  CalendarDataSource.swift
//  booklendar
//
//  Created by Song on 2021/09/28.
//

import UIKit

final class CalendarDataSource: NSObject {
    private(set) var sections = [[DayRecord]]()
    
    // 기존 데이터 세팅을 해줘야 할텐데..?
    // 어딘가에 저장을 공통으로 해두고 다같이 꺼내 써야할듯
    func new(month: [DayRecord]) {
        sections.append(month)
    }
    
    func update(_ routine: Routine) {
        guard !routine.records.isEmpty else { return }
        
        let targetDate = routine.date
        
        for dayRecords in sections {
            for dayRecord in dayRecords {
                if dayRecord.day.date == targetDate {
                    dayRecord.record = routine.records[0]
                }
            }
        }
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
        let dayRecord = sections[indexPath.section][indexPath.row]
        cell.configure(with: dayRecord)
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
