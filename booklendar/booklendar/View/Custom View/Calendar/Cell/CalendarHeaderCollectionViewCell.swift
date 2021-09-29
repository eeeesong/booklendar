//
//  CalendarHeaderCollectionViewCell.swift
//  booklendar
//
//  Created by Song on 2021/09/27.
//

import UIKit

final class CalendarHeaderCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95)
        ])
    }
    
    func configure(with headerInfo: HeaderInfo) {
        switch headerInfo {
        case .month(let text):
            titleLabel.font = UIFont.bigCalendarTitle()
            titleLabel.text = text
            titleLabel.textAlignment = .left
        case .week(let text):
            titleLabel.font = UIFont.smallCalendarTitle()
            titleLabel.text = text
            titleLabel.textAlignment = .center
        }
    }
}

enum HeaderInfo {
    case month(String)
    case week(String)
}
