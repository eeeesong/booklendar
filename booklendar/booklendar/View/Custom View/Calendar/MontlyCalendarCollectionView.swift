//
//  MontlyCalendarCollectionView.swift
//  booklendar
//
//  Created by Song on 2021/09/27.
//

import UIKit

final class MontlyCalendarCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        setup()
        registerCells()
    }
    
    private func setup() {
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func registerCells() {
        registerContentsCell()
        registerHeaderCell()
    }
    
    private func registerContentsCell() {
        let cellId = MontlyCalendarCollectionViewCell.identifier
        register(MontlyCalendarCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func registerHeaderCell() {
        let cellId = CalendarHeaderCollectionViewCell.identifier
        register(CalendarHeaderCollectionViewCell.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: cellId)
    }
}
