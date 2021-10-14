//
//  DetailHeaderCollectionViewCell.swift
//  booklendar
//
//  Created by Song on 2021/10/14.
//

import UIKit

final class DetailHeaderCollectionViewCell: UICollectionViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021. 10. 13."
        label.font = UIFont.smallCalendarTitle()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageFrame: FramedImageView = {
        let imageView = FramedImageView()
        imageView.backgroundColor = .cyan
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "지구인만큼 지구를 사랑할 순 없어"
        label.font = UIFont.bookTitle()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "정세랑"
        label.font = UIFont.body()
        label.textAlignment = .center
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
        addDateLabel()
        addImageFrame()
        addbookInfoLabels()
    }
    
    private func addDateLabel() {
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95)
        ])
    }
    
    private func addImageFrame() {
        addSubview(imageFrame)
        
        NSLayoutConstraint.activate([
            imageFrame.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageFrame.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            imageFrame.heightAnchor.constraint(equalTo: imageFrame.widthAnchor, multiplier: 1.6),
            imageFrame.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func addbookInfoLabels() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageFrame.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95)
        ])
        
        addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            authorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95)
        ])
    }
    
    func configure(with dayRecord: DayRecord) {
        let dateText = DateFormatter.dateToString(format: DateFormat.dateKey, date: dayRecord.day.date)
        dateLabel.text = dateText
        
        let book = dayRecord.record?.book
        titleLabel.text = book?.title
        authorLabel.text = book?.authors.joined(separator: ", ")
    }
}
