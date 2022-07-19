//
//  NotificationTime.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/19.
//

struct NotificationTime: Hashable {
    var weekDay: String
    var hour: Int
    var minute: Int
    var isSelcted: Bool
}

extension NotificationTime {
    static func setDummyData() -> [NotificationTime] {
        let dummyData = [NotificationTime(weekDay: "월", hour: 3, minute: 0, isSelcted: true),NotificationTime(weekDay: "화", hour: 4, minute: 0, isSelcted: true),NotificationTime(weekDay: "수", hour: 5, minute: 0, isSelcted: true),NotificationTime(weekDay: "목", hour: 6, minute: 0, isSelcted: true),NotificationTime(weekDay: "금", hour: 7, minute: 0, isSelcted: true),NotificationTime(weekDay: "토", hour: 8, minute: 0, isSelcted: true),NotificationTime(weekDay: "일", hour: 9, minute: 0, isSelcted: true)]
        return dummyData
    }
}
