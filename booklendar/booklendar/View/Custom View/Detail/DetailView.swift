//
//  DetailView.swift
//  booklendar
//
//  Created by Song on 2021/10/24.
//

import UIKit

typealias DetailHandler = (DetailAction) -> Void

enum DetailAction {
    case searchButtonTouched
}

final class DetailView: UIView {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
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
    
    private lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.tintColor = .white
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.isHidden = true
        searchButton.addTarget(self, action: #selector(searchButtonTouched), for: .touchUpInside)
        return searchButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bookTitle()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.body()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.body()
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isSelectable = true
        textView.textContainerInset = .init(top: 10, left: 12, bottom: 10, right: 12)
        textView.layer.borderWidth = 1
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var actionHandler: DetailHandler?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        addDateLabel()
        addImageFrame()
        addSearchButton()
        addbookInfoLabels()
        addCommentTextView()
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
    
    private func addSearchButton() {
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: imageFrame.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: imageFrame.centerYAnchor),
            searchButton.widthAnchor.constraint(equalTo: imageFrame.widthAnchor),
            searchButton.heightAnchor.constraint(equalTo: imageFrame.heightAnchor)
        ])
    }
    
    private func removeSearchButton() {
        searchButton.removeFromSuperview()
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
    
    private func addCommentTextView() {
        addSubview(commentTextView)
        
        NSLayoutConstraint.activate([
            commentTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            commentTextView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            commentTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            commentTextView.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    func setActionHandler(_ actionHandler: @escaping DetailHandler) {
        self.actionHandler = actionHandler
    }
    
    func configure(with dateString: String,_ book: Book?) {
        dateLabel.text = dateString
        titleLabel.text = book?.title
        authorLabel.text = book?.authors.joined(separator: ", ")
    }
    
    func searchMode(isOn: Bool) {
        commentTextView.isEditable = isOn
        searchButton.isHidden = !isOn
    }
    
    @objc private func searchButtonTouched(_ sender: UIButton) {
        actionHandler?(.searchButtonTouched)
    }
}
