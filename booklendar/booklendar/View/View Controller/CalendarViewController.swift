//
//  CalendarViewController.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import UIKit

final class CalendarViewController: UIViewController {

    lazy var monthlyCalendarView: MontlyCalendarCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        let calendarView = MontlyCalendarCollectionView(frame: .zero, collectionViewLayout: layout)
        return calendarView
    }()
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 임시
        monthlyCalendarView.delegate = self
        monthlyCalendarView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.monthlyCalendarView.reloadData()
        }
    }
    
    private func configure() {
        addCalendarView()
    }
    
    private func addCalendarView() {
        view.addSubview(monthlyCalendarView)
        
        NSLayoutConstraint.activate([
            monthlyCalendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monthlyCalendarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            monthlyCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50), // 임시
            monthlyCalendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = MontlyCalendarCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MontlyCalendarCollectionViewCell ?? MontlyCalendarCollectionViewCell()
        cell.configure(with: "\(Int.random(in: 1...31))", "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerId = CalendarHeaderCollectionViewCell.identifier
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? CalendarHeaderCollectionViewCell ?? CalendarHeaderCollectionViewCell()
            let headerInfo = HeaderInfo.month("September 2021")
            header.configure(with: headerInfo)
            return header
        default:
            assert(false)
        }
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / 7.0
        let cellHeight = cellWidth * 1.7
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
