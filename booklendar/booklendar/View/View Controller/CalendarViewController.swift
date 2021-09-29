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
    
    private var monthlyCalendarDrawer: MonthlyCalendarDrawer?
    private var calendarDataSource: CalendarDataSource?
    private lazy var calenderWidth = view.frame.width * 0.95
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarViewHelpers()
        drawCalendarBorders()
    }
    
    private func configure() {
        addCalendarView()
    }
    
    private func addCalendarView() {
        view.addSubview(monthlyCalendarView)
        
        NSLayoutConstraint.activate([
            monthlyCalendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monthlyCalendarView.widthAnchor.constraint(equalToConstant: calenderWidth),
            monthlyCalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50), // 임시
            monthlyCalendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setCalendarViewHelpers() {
        monthlyCalendarDrawer = MonthlyCalendarDrawer(calendarWidth: calenderWidth)
        monthlyCalendarView.delegate = monthlyCalendarDrawer
        
        calendarDataSource = CalendarDataSource()
        monthlyCalendarView.dataSource = calendarDataSource
    }
    
    private func drawCalendarBorders() {
        calendarDataSource!.sections.enumerated().forEach { section, cellCount in
            monthlyCalendarDrawer?.addNewBox(to: monthlyCalendarView, for: section, with: cellCount)
        }
    }
}
