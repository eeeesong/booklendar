//
//  CalendarViewController.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import UIKit

final class CalendarViewController: UIViewController {

    private lazy var monthlyCalendarView: MontlyCalendarCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let calendarView = MontlyCalendarCollectionView(frame: .zero, collectionViewLayout: layout)
        return calendarView
    }()
    
    var previousBoxEndsAt: CGFloat = 0
    private let sections = [30, 31, 29, 28, 35]
    
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
        
        for i in 0..<sections.count {
            let layer = outlineBox(for: i, cellCount: sections[i])
            monthlyCalendarView.layer.addSublayer(layer)
        }
    }
    
    private func outlineBox(for section: Int, cellCount: Int) -> CALayer {
        let layer = CALayer()
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 1
        let outlineWidth = monthlyCalendarView.frame.width
        let heightUnit = (outlineWidth - 10) / 7 * 1.7
        let heightCount = cellCount / 7 + (cellCount % 7 == 0 ? 0 : 1)
        let outlineHeight = CGFloat(heightCount) * heightUnit + 20
        layer.frame = CGRect(x: 0, y: previousBoxEndsAt + 100, width: outlineWidth, height: outlineHeight)
        previousBoxEndsAt += 100 + outlineHeight
        return layer
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
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section]
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
        let cellWidth = (collectionView.bounds.width - 10) / 7.0
        let cellHeight = cellWidth * 1.7
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 4, bottom: 10, right: 4)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
