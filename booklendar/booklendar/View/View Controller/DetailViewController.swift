//
//  DetailViewController.swift
//  booklendar
//
//  Created by Song on 2021/10/13.
//

import UIKit

final class DetailViewController: UIViewController, ViewModelIncludable {
    
    // View
    typealias DetailCollectionView = BooklendarCollectionView<CommentCollectionViewCell,
                                                              DetailHeaderCollectionViewCell>
    private lazy var detailCollectionView: DetailCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = DetailCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(image: .init(systemName: "arrowshape.turn.up.backward.fill"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTouched))
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backButton
        return backButton
    }()
    
    // View Helpers
    private var detailCollectionViewDrawer: DetailCollectionViewDrawer?
    private var detailCollectionViewDataSource: DetailCollectionViewDataSource?

    // View Model
    var viewModel: DetailViewModelType?
    
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
        
        guard let details = viewModel?.initialData() else { return }
        detailCollectionViewDataSource = DetailCollectionViewDataSource(date: details.date, records: details.records)
        detailCollectionView.dataSource = detailCollectionViewDataSource
    }
    
    @objc func backButtonTouched(_ sender: UIBarButtonItem) {
        viewModel?.editingFinished()
    }
}
