//
//  MontlyCalendarCollectionViewCell.swift
//  booklendar
//
//  Created by Song on 2021/09/27.
//

import UIKit

final class MontlyCalendarCollectionViewCell: UICollectionViewCell {
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return UILabel()
    }()
    
    lazy var coverImageView: FramedImageView = {
        let imageView = FramedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return FramedImageView()
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
        addDayLabel()
        addCoverImageView()
    }
    
    private func addDayLabel() {
        addSubview(dayLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalToSystemSpacingBelow: centerYAnchor, multiplier: 0.4)
        ])
    }
    
    private func addCoverImageView() {
        addSubview(coverImageView)
        
        NSLayoutConstraint.activate([
            coverImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            coverImageView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 10),
            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 1.7)
        ])
    }
    
    func configure(with day: String, _ imageUrl: String) {
        dayLabel.text = day
        // 캐시 객체 통해 이미지 불러오는 코드 작성
        coverImageView.backgroundColor = .green
    }
}
