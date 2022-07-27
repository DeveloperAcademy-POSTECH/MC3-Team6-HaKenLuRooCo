//
//  NotificationTime.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/19.
//

import UIKit

class NotificationButton {
    var indexPath: Int
    var buttonStack: UIStackView
    var isSelected: Bool
    var notificationTime: Date
    init(id: Int, buttonStack: UIStackView, isSelected: Bool, notificationTime: Date) {
        self.indexPath = id
        self.buttonStack = buttonStack
        self.isSelected = false
        self.notificationTime = notificationTime
    }
}

enum WeekDay: String, CaseIterable {
    case mon = "월"
    case tue = "화"
    case wed = "수"
    case thur = "목"
    case fri = "금"
    case sat = "토"
    case sun = "일"
}
