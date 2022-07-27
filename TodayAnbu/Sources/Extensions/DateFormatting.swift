//
//  DateFormatting.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/25.
//
import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // 2022-07-03 23:14
        return dateFormatter.string(from: self)
    }
}
