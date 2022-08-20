//
//  MontlyCalendarCollectionViewCell.swift
//  booklendar
//
//  Created by Song on 2021/09/27.
//

import UIKit

final class MonthlyCalendarCollectionViewCell: UICollectionViewCell {
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.date()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var coverImageView: FramedImageView = {
        let imageView = FramedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
            dayLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95),
            dayLabel.heightAnchor.constraint(equalToConstant: frame.height * 0.15),
            dayLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func addCoverImageView() {
        addSubview(coverImageView)
        
        NSLayoutConstraint.activate([
            coverImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            coverImageView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 8),
            coverImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with dayRecord: DayRecord) {
        let day = dayRecord.day
        guard let realDate = day.date else {
            dayLabel.text = nil
            coverImageView.reset()
            return
        }
        
        let onlyDay = DateFormatter.dateToString(format: DateFormat.onlyDay, date: realDate)
        dayLabel.text = onlyDay
        isUserInteractionEnabled = !day.isFuture
        
        guard let record = dayRecord.record else {
            coverImageView.reset()
            return
        }
        
        let imageUrl = record.book.coverUrl
        guard let imageData = try? Data(contentsOf: URL(string: imageUrl)!) else { return }
        let image = UIImage(data: imageData) ?? UIImage()
        coverImageView.configure(with: image, style: record.frameStyle)
    }
}
