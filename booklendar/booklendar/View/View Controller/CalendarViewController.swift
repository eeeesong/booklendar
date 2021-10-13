//
//  CalendarViewController.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import UIKit

final class CalendarViewController: UIViewController {

    // View
    private lazy var monthlyCalendarView: MontlyCalendarCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let calendarView = MontlyCalendarCollectionView(frame: .zero, collectionViewLayout: layout)
        return calendarView
    }()
    private lazy var calenderWidth = view.frame.width * 0.95
    
    // View Helpers
    private var monthlyCalendarDrawer: MonthlyCalendarDrawer?
    private var calendarDataSource: CalendarDataSource?
    
    // View Model
    private var viewModel: CalendarViewModelType?
    
    override func loadView() {
        super.loadView()
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarViewHelpers()
        set(viewModel: CalendarViewModel())
    }
    
    private func configure() {
        view.backgroundColor = .white
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
        monthlyCalendarDrawer = MonthlyCalendarDrawer(calendarWidth: calenderWidth,
                                                      actionHandler: viewNeedsChanges(with:))
        monthlyCalendarView.delegate = monthlyCalendarDrawer
        
        calendarDataSource = CalendarDataSource()
        monthlyCalendarView.dataSource = calendarDataSource
    }
    
    func set(viewModel: CalendarViewModelType) {
        self.viewModel = viewModel
        
        viewModel.initialData(of: 2).forEach { month in
            newMonthLoaded(month)
        }
    }
    
    private func newMonthLoaded(_ newMonth: [DayRecord]) {
        calendarDataSource?.new(month: newMonth)
        
        DispatchQueue.main.async {
            self.monthlyCalendarView.reloadData()
        }
        
        guard let currentSection = calendarDataSource?.sections.count else { return }
        monthlyCalendarDrawer?.addNewBox(to: monthlyCalendarView, for: currentSection - 1, with: newMonth.count)
    }
    
    func viewNeedsChanges(with action: CalendarAction) {
        guard let viewModel = viewModel else { return }
        
        switch action {
        case .needsMore:
            let newMonth = viewModel.newCalendarNeeded()
            newMonthLoaded(newMonth)
        case .selectedAt(let indexPath):
            print(indexPath)
            let nextVC = DetailViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
