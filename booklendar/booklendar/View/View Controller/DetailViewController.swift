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

    // View Model
    private var viewModel: DetailViewModelType?
    
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
        
        detailCollectionViewDataSource = DetailCollectionViewDataSource(dayRecord: viewModel?.initialData())
        detailCollectionView.dataSource = detailCollectionViewDataSource
    }
    
    func set(_ viewModel: DetailViewModelType) {
        self.viewModel = viewModel
    }
}
