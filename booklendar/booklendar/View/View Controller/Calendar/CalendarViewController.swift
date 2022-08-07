//
//  CalendarViewController.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import UIKit

final class CalendarViewController: UIViewController, ViewModelIncludable {
    
    typealias MonthlyCalendarView = BooklendarCollectionView<MonthlyCalendarCollectionViewCell,
                                                             CalendarHeaderCollectionViewCell>
    // View
    private lazy var menuButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"),
                                     style: .plain,
                                     target: nil,
                                     action: nil)
        button.tintColor = .darkGray
        return button
    }()
    
    private lazy var writeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "pencil"),
                                     style: .plain,
                                     target: nil,
                                     action: nil)
        button.tintColor = .darkGray
        return button
    }()
    
    private lazy var weekView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var monthlyCalendarView: MonthlyCalendarView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let calendarView = MonthlyCalendarView(frame: .zero, collectionViewLayout: layout)
        return calendarView
    }()
    private lazy var fullWidth = view.frame.width
    private lazy var calenderWidth = fullWidth * 0.95
    
    // View Helpers
    private var monthlyCalendarDrawer: MonthlyCalendarDrawer?
    private var calendarDataSource: CalendarDataSource?
    
    // View Model
    var viewModel: CalendarViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarViewHelpers()
        setInitialData()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = menuButton
        navigationItem.rightBarButtonItem = writeButton
        navigationController?.navigationBar.backgroundColor = UIColor(named: "lime")
        addViews()
    }
    
    private func addViews() {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .lightGray
        
        view.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.widthAnchor.constraint(equalToConstant: fullWidth),
            lineView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        view.addSubview(weekView)
        NSLayoutConstraint.activate([
            weekView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weekView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            weekView.widthAnchor.constraint(equalToConstant: fullWidth),
            weekView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let days = "MTWTFSS"
        for day in days {
            let label = UILabel()
            label.text = String(day)
            label.font = .smallCalendarTitle()
            label.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(label)
        }
        
        weekView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: weekView.widthAnchor, multiplier: 0.8),
            stackView.heightAnchor.constraint(equalTo: weekView.heightAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: weekView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: weekView.centerYAnchor)
        ])
        
        let lineView2 = UIView()
        lineView2.translatesAutoresizingMaskIntoConstraints = false
        lineView2.backgroundColor = .lightGray
        
        view.addSubview(lineView2)
        NSLayoutConstraint.activate([
            lineView2.heightAnchor.constraint(equalToConstant: 1),
            lineView2.widthAnchor.constraint(equalToConstant: fullWidth),
            lineView2.topAnchor.constraint(equalTo: weekView.bottomAnchor),
            lineView2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        view.addSubview(monthlyCalendarView)
        NSLayoutConstraint.activate([
            monthlyCalendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            monthlyCalendarView.topAnchor.constraint(equalTo: lineView2.bottomAnchor),
            monthlyCalendarView.widthAnchor.constraint(equalToConstant: calenderWidth),
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
    
    private func setInitialData() {
        viewModel?.initialData(of: 2).forEach { month in
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
            viewModel.calendarCellSelected(at: indexPath)
        }
    }
}

extension CalendarViewController: NewStateAcceptable {
    func accept<State>(newState: State) {
        print(newState)
    }
}
