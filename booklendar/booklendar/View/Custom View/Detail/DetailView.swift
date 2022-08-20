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
        imageView.configure(with: UIImage(), style: FramedImageView.Style.random())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        let searchImage = UIImage(systemName: "magnifyingglass")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.tintColor = Colors.menu
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
        textView.typingAttributes = [.font: UIFont.bookTitle(), .baselineOffset: 5]
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isSelectable = true
        textView.textContainerInset = .init(top: 20, left: 12, bottom: 20, right: 12)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Colors.line.cgColor
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
            imageFrame.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageFrame.heightAnchor.constraint(equalTo: imageFrame.widthAnchor, multiplier: 1.1),
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
        let dividerLineView = UIView()
        dividerLineView.backgroundColor = Colors.line
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dividerLineView)
        NSLayoutConstraint.activate([
            dividerLineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dividerLineView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            dividerLineView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            dividerLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        addSubview(commentTextView)
        
        NSLayoutConstraint.activate([
            commentTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            commentTextView.topAnchor.constraint(equalTo: dividerLineView.bottomAnchor, constant: 20),
            commentTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            commentTextView.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
    
    func setActionHandler(_ actionHandler: @escaping DetailHandler) {
        self.actionHandler = actionHandler
    }
    
    func configure(with dateString: String,_ book: Book?) {
        dateLabel.text = dateString
        
        guard let book = book else {
            titleLabel.text = "연필 버튼을 눌러서 책을 등록해주세요."
            authorLabel.text = ""
            imageFrame.configure(with: UIImage(), style: .random())
            return
        }
        
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        
        guard let imageData = try? Data(contentsOf: URL(string: book.coverUrl)!) else { return }
        let newImage = UIImage(data: imageData) ?? UIImage()
        imageFrame.configure(with: newImage, style: .random())
    }
    
    func searchMode(isOn: Bool) {
        commentTextView.isEditable = isOn
        searchButton.isHidden = !isOn
    }
    
    @objc private func searchButtonTouched(_ sender: UIButton) {
        actionHandler?(.searchButtonTouched)
    }
}
