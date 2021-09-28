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
    
    // 임시
    var previousBoxEndsAt: CGFloat = 0
    
    private let sections = [30, 31, 29, 28, 35]
    private var monthlyCalendarDrawer: MonthlyCalendarDrawer?
    private var calendarDataSource: CalendarDataSource?
    
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
    
    private func addOutlineBoxes() {
        for i in 0..<sections.count {
            let layer = outlineBox(for: i, cellCount: sections[i])
            monthlyCalendarView.layer.addSublayer(layer)
        }
    }
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        monthlyCalendarDrawer = MonthlyCalendarDrawer(calendarWidth: monthlyCalendarView.frame.width)
        monthlyCalendarView.delegate = monthlyCalendarDrawer
        
        calendarDataSource = CalendarDataSource()
        monthlyCalendarView.dataSource = calendarDataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.monthlyCalendarView.reloadData()
        }
        addOutlineBoxes()
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
