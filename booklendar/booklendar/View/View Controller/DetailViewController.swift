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
    
    private lazy var commentCollectionView: DetailCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = DetailCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
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
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        
        DispatchQueue.main.async {
            self.commentCollectionView.reloadData()
        }
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
        view.addSubview(commentCollectionView)
        
        NSLayoutConstraint.activate([
            commentCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commentCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            commentCollectionView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            commentCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width * 0.8
        let height = width
        return CGSize(width: width, height: height)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = CommentCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? CommentCollectionViewCell ?? CommentCollectionViewCell()
        let commentInfo = CommentInfo(date: "2021. 10. \(indexPath.row + 5)",
                                      body: String(repeating: "안녕하세요. 테스트입니다.", count: indexPath.row * 10))
        cell.configure(with: commentInfo)
        return cell
    }
}
