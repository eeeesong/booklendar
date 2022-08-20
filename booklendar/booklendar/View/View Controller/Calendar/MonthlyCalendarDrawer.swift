//
//  MonthlyCalendarDrawer.swift
//  booklendar
//
//  Created by Song on 2021/09/28.
//

import UIKit

typealias CalendarHandler = (CalendarAction) -> Void

enum CalendarAction {
    case needsMore
    case selectedAt(IndexPath)
}

final class MonthlyCalendarDrawer: NSObject {
    
    private var previousBoxEndsAt: CGFloat
    private let calendarWidth: CGFloat
    private var outlineBoxes: [CALayer]
    private lazy var cellWidth = (calendarWidth - Constants.inset) / Constants.cell
    private lazy var cellHeight = cellWidth * 1.7
    private lazy var headerHeight = cellHeight * 1.05
    private var actionHandler: CalendarHandler
    
    enum Constants {
        static let cell: CGFloat = 7
        static let inset: CGFloat = 10
    }
    
    init(calendarWidth: CGFloat, previousBoxEndsAt: CGFloat = 0, outlineBoxes: [CALayer] = [], actionHandler: @escaping CalendarHandler) {
        self.calendarWidth = calendarWidth
        self.previousBoxEndsAt = previousBoxEndsAt
        self.outlineBoxes = outlineBoxes
        self.actionHandler = actionHandler
    }
    
    func addNewBox(to monthlyCalendarView: UICollectionView, for section: Int, with cellCount: Int) {
        let newBox = outlineBox(for: section, with: cellCount)
        outlineBoxes.append(newBox)
        monthlyCalendarView.layer.addSublayer(newBox)
    }
    
    private func outlineBox(for section: Int, with cellCount: Int) -> CALayer {
        let heightWeight = heightWeight(for: cellCount)
        let outlineHeight = CGFloat(heightWeight) * cellHeight + Constants.inset * 2
        let yPosition = previousBoxEndsAt + headerHeight
        
        let outlineBox = outlineBox()
        outlineBox.frame = CGRect(x: 0, y: yPosition, width: calendarWidth, height: outlineHeight)
        previousBoxEndsAt += headerHeight + outlineHeight
        return outlineBox
    }
    
    private func heightWeight(for cellCount: Int) -> Int {
        let cellUnit = Int(Constants.cell)
        let quotient = cellCount / cellUnit
        let remainder = cellCount % cellUnit
        return quotient + (remainder == 0 ? 0 : 1)
    }
    
    private func outlineBox() -> CALayer {
        let layer = CALayer()
        layer.borderColor = Colors.line.cgColor
        layer.borderWidth = 1
        return layer
    }
}

extension MonthlyCalendarDrawer: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let full = Constants.inset
        let half = full / 2
        return UIEdgeInsets(top: full, left: half, bottom: full, right: half)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        actionHandler(.needsMore)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionHandler(.selectedAt(indexPath))
    }
}
