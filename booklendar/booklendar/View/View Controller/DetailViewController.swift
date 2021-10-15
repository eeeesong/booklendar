//
//  DetailViewController.swift
//  booklendar
//
//  Created by Song on 2021/10/13.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // View
    private lazy var detailCollectionView: BooklendarCollectionView<CommentCollectionViewCell,
                                                                     DetailHeaderCollectionViewCell> = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = BooklendarCollectionView<CommentCollectionViewCell,
                                                      DetailHeaderCollectionViewCell> (frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // View Helpers
    private var detailCollectionViewDrawer: DetailCollectionViewDrawer?
    private var detailCollectionViewDataSource: DetailCollectionViewDataSource?

    override func loadView() {
        super.loadView()
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailViewHelpers()
    }
    
    private func configure() {
        view.backgroundColor = .white
        addCommentView()
    }

    private func addCommentView() {
        view.addSubview(detailCollectionView)
        
        NSLayoutConstraint.activate([
            detailCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            detailCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            detailCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func setDetailViewHelpers() {
        detailCollectionViewDrawer = DetailCollectionViewDrawer()
        detailCollectionView.delegate = detailCollectionViewDrawer
        
        let tempRecord = DayRecord(day: Day(isFuture: false, date: Date(), isEmpty: false),
                                   record: Record(order: 0, book: Book(recentlyAdded: Date(), id: "", coverUrl: "", title: "SAVAGE", authors: ["에스파"], translators: [], publisher: "", page: 400), comment: "oh my gosh~ don't you know i'm a"))
        detailCollectionViewDataSource = DetailCollectionViewDataSource(record: tempRecord)
        detailCollectionView.dataSource = detailCollectionViewDataSource
    }
}
