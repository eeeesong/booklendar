//
//  CommentCollectionView.swift
//  booklendar
//
//  Created by Song on 2021/10/14.
//

import UIKit

final class DetailCollectionView: UICollectionView {
    
    private lazy var calendarColor = CalendarColor.background
    
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
        backgroundColor = calendarColor
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func registerCells() {
        registerContentsCell()
        registerHeaderCell()
    }
    
    private func registerContentsCell() {
        let cellId = CommentCollectionViewCell.identifier
        register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func registerHeaderCell() {
        let cellId = DetailHeaderCollectionViewCell.identifier
        register(DetailHeaderCollectionViewCell.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: cellId)
    }
}
