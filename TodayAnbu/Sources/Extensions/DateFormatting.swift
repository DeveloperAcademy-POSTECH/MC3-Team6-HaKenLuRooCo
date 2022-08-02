//
//  DateFormatting.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/25.
//
import Foundation

extension Date {
    static var currentNumericLocalizedDateTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "yyMMddHHmmss" // 220703231423 (KST)
        return dateFormatter.string(from: Date())
    }

    static var currentNaturalLocalizedDatetTime: String {
        let now = Date()
        let dateText = now.formatted(.dateTime.year().month(.abbreviated).day())
        let timeText = now.formatted(date: .omitted, time: .shortened)
        let dateAndTimeFormat = NSLocalizedString("%@, %@", comment: "Date and time format string") // 2022년 7월. 29일, 오전 12:47
        return String(format: dateAndTimeFormat, dateText, timeText)
    }

    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // 2022-07-03 23:14
        return dateFormatter.string(from: self)
    }

    static func dayDifference(_ before: String, _ after: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMddHHmmss" // 202207032314 (KST)
        guard let beforeDate = dateFormatter.date(from: before) else { return nil }
        guard let afterDate = dateFormatter.date(from: after) else { return nil }
        let interval = afterDate.timeIntervalSince(beforeDate)
        return Int(interval / 86400)
    }
}
