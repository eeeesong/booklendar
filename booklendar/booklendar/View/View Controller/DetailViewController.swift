//
//  DetailViewController.swift
//  booklendar
//
//  Created by Song on 2021/10/13.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // View
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
        addCommentView()
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        
        DispatchQueue.main.async {
            self.commentCollectionView.reloadData()
        }
    }

    private func addCommentView() {
        view.addSubview(commentCollectionView)
        
        NSLayoutConstraint.activate([
            commentCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            commentCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            commentCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.bounds.width * 0.8
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerId = DetailHeaderCollectionViewCell.identifier
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? DetailHeaderCollectionViewCell ?? DetailHeaderCollectionViewCell()
            let dayRecord = DayRecord(day: Day(isFuture: true, date: Date(), isEmpty: false),
                                      record: Record(order: 0, book: Book(recentlyAdded: Date(), id: "", coverUrl: "", title: "SAVAGE", authors: ["에스파","이수만","유영진"], translators: [], publisher: "", page: 400), comment: "하하하"))
            header.configure(with: dayRecord)
            return header
        default:
            assert(false)
        }
    }
}
