//
//  Calendar.swift
//  booklendar
//
//  Created by Song on 2021/09/19.
//

import Foundation

protocol CalendarManagable {
    func routine(for key: String) -> Routine?
    func loadLastData() -> [DayRecord]
    func update(from routine: Routine)
}

final class CalendarManager: CalendarManagable {
    private let calendar = Calendar(identifier: .gregorian)
    private var months = [[Day]]()
    private var routines: [String: Routine]
    
    init(routines: [String: Routine]) {
        self.routines = routines
    }
    
    func routine(for key: String) -> Routine? {
        return routines[key]
    }
    
    func loadLastData() -> [DayRecord] {
        if let lastMonth = months.last {
            let currentDate = lastMonth[15].date!
            let pastMonthDate = pastMonthDate(from: currentDate)
            createMonth(startAt: pastMonthDate)
        } else {
            createMonth(startAt: Date())
        }
        
        let dayRecords = months.last!
            .map { DayRecord(day: $0, record: mainBook(for: $0.date)) }
        return dayRecords
    }
    
    func update(from routine: Routine) {
        let key = routine.date.dateToString(format: DateFormat.dateKey)
        routines[key] = routine
    }
    
    private func pastMonthDate(from currentDate: Date) -> Date {
        let pastMonthDate = calendar.date(byAdding: .month, value: -1, to: currentDate)
        return pastMonthDate ?? Date()
    }
    
    private func mainBook(for date: Date?) -> Record? {
        guard let date = date else { return nil }
        
        let dateKey = DateFormatter.dateToString(format: DateFormat.dateKey, date: date)
        
        guard let day = routines[dateKey] else {
            return nil
        }
        return day.main()
    }
    
    private func createMonth(startAt: Date) {
        guard let numberOfDays = calendar.range(of: .day, in: .month, for: startAt)?.count,
              let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: startAt))
        else { return }
        let startingWeekday = calendar.component(.weekday, from: firstDay)
        let month = createDays(with: firstDay, numberOfDays, startingWeekday)
        months.append(month)
    }
    
    private func createDays(with firstDay: Date, _ numberOfDays: Int, _ startingWeekDay: Int) -> [Day] {
        let emptyDay = Day(isFuture: true, date: nil, isEmpty: true)
        var days = Array(repeating: emptyDay, count: startingWeekDay - 1)

        for i in 0..<numberOfDays {
            let date = calendar.date(byAdding: .day, value: i, to: firstDay) ?? Date()
            let status = isFuture(date: date)
            days.append(Day(isFuture: status, date: date, isEmpty: false))
        }
        return days
    }
    
    private func isFuture(date: Date, compareTo: Date = Date()) -> Bool {
        return date > compareTo || isSameDay(date: date)
    }
    
    private func isSameDay(date: Date, compareTo: Date = Date()) -> Bool {
        let day = calendar.dateComponents([.day], from: date).day
        let dayToCompare = calendar.dateComponents([.day], from: compareTo).day
        return day == dayToCompare
    }
}
