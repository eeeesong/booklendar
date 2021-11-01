//
//  BookTableViewCell.swift
//  booklendar
//
//  Created by Song on 2021/11/01.
//

import UIKit

final class BookTableViewCell: UITableViewCell {

    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let spacing: CGFloat = 10
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    private func configure() {
        addCoverImageView()
        addLabels()
    }
    
    private func addCoverImageView() {
        addSubview(coverImageView)
        
        NSLayoutConstraint.activate([
            coverImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
            coverImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addLabels() {
        addSubview(titleLabel)
        addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: spacing),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: spacing),
            infoLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: spacing),
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -spacing)
        ])
    }
    
    func configure(with book: Book) {
        titleLabel.text = book.title
        infoLabel.text = book.authors.joined(separator: ",") + " / " + book.publisher
    }
}
