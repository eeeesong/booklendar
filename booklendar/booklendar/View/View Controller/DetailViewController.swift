//
//  DetailViewController.swift
//  booklendar
//
//  Created by Song on 2021/10/13.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // View
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
    
    private lazy var commentView: UITextView = {
        let textView = UITextView()
        textView.text = "이곳에 전체 코멘트가 표시된다"
        textView.font = UIFont.body()
        textView.textAlignment = .left
        textView.layer.borderWidth = 1
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        addDateLabel()
        addImageFrame()
        addbookInfoLabels()
        addCommentView()
    }
    
    private func addDateLabel() {
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95)
        ])
    }
    
    private func addImageFrame() {
        view.addSubview(imageFrame)
        
        NSLayoutConstraint.activate([
            imageFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageFrame.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            imageFrame.heightAnchor.constraint(equalTo: imageFrame.widthAnchor, multiplier: 1.6),
            imageFrame.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func addbookInfoLabels() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageFrame.bottomAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95)
        ])
        
        view.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95)
        ])
    }
    
    private func addCommentView() {
        view.addSubview(commentView)
        
        NSLayoutConstraint.activate([
            commentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            commentView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            commentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
