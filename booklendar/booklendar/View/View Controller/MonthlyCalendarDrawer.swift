//
//  MonthlyCalendarDrawer.swift
//  booklendar
//
//  Created by Song on 2021/09/28.
//

import UIKit

final class MonthlyCalendarDrawer: NSObject {
    
    private var previousBoxEndsAt: CGFloat
    private let calendarWidth: CGFloat
    private var outlineBoxes: [CALayer]
    
    init(calendarWidth: CGFloat, previousBoxEndsAt: CGFloat = 0, outlineBoxes: [CALayer] = []) {
        self.calendarWidth = calendarWidth
        self.previousBoxEndsAt = previousBoxEndsAt
        self.outlineBoxes = outlineBoxes
    }
    
    private func outlineBox() -> CALayer {
        let layer = CALayer()
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        return layer
    }
    
    private func outlineBox(for section: Int, cellCount: Int) -> CALayer {
        let layer = outlineBox()
        let outlineWidth = calendarWidth
        let heightUnit = (outlineWidth - 10) / 7 * 1.7
        let heightCount = cellCount / 7 + (cellCount % 7 == 0 ? 0 : 1)
        let outlineHeight = CGFloat(heightCount) * heightUnit + 20
        layer.frame = CGRect(x: 0, y: previousBoxEndsAt + 100, width: outlineWidth, height: outlineHeight)
        previousBoxEndsAt += 100 + outlineHeight
        return layer
    }
    
    private func addOutlineBoxes(to monthlyCalendarView: UICollectionView) {
//        for i in 0..<outlineBoxes.count {
//            let layer = outlineBox(for: i, cellCount: sections[i])
//            monthlyCalendarView.layer.addSublayer(layer)
//        }
    }
}

extension MonthlyCalendarDrawer: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 10) / 7.0
        let cellHeight = cellWidth * 1.7
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
