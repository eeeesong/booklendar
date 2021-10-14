//
//  CommentCollectionViewCell.swift
//  booklendar
//
//  Created by Song on 2021/10/14.
//

import UIKit

final class CommentCollectionViewCell: UICollectionViewCell {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bookTitle()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.body()
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isSelectable = true
        textView.textContainerInset = .init(top: 10, left: 12, bottom: 10, right: 12)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        addCommentTextView()
    }
    
    private func addDateLabel() {
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            dateLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9)
        ])
    }
    
    private func addCommentTextView() {
        addSubview(commentTextView)
        
        NSLayoutConstraint.activate([
            commentTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            commentTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: -15),
            commentTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            commentTextView.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    func configure(with commentInfo: CommentInfo) {
        
    }
}

struct CommentInfo {
    let date: String
    let body: String
}
