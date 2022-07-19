//
//  NotificationModalViewController.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/19.
//

import UIKit
import UserNotifications

class NotificationModalViewController: UIViewController {

    var showModal = true
    let timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.preferredDatePickerStyle = .wheels
        return timePicker
    }()
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    let settingDoneButton: UIButton = {
        let button = UIButton()
        button.setTitle("설정 완료!", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(settingDoneButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        timePickerLayOut()
        settingButtonLayOut()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (permissionGranted, _) in
            if !permissionGranted {
                print("Permission Denied")
            }
        }
    }
    
    private func timePickerLayOut() {
        self.view.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func settingButtonLayOut() {
        self.view.addSubview(settingDoneButton)
        settingDoneButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingDoneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            settingDoneButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            settingDoneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
    }
    
    @objc func settingDoneButtonAction(_ sender: UIButton!) {
        dismiss(animated: true)
        print("버튼이 선택되었음")
    }
    // 알람 설정 버튼과 연동해야함, Completion Feedback(진동,소리)은 버튼 애니메이션과 파란색 활성화로 대체
    @IBAction func setAlarmSchedule(_ sender: Any) { notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                let title = "부모님께 전화안한지 10일!"
                let message = "오늘,안부의 알람입니다."
                let date = self.timePicker.date
                if settings.authorizationStatus == .authorized {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    // dateComponent가 버튼 클릭에따라 바껴야함
                    let dateComponent = Calendar.current.dateComponents([  .day, .hour, .minute], from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    self.notificationCenter.add(request) { error in
                        if error != nil {
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                } else {
                    let alertController = UIAlertController(title: "알림을 설정하시겠어요?", message: "설정에서 알람 허용을 해주셔야해요!", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "설정", style: .default) { _ in
                        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                        if UIApplication.shared.canOpenURL(settingURL) {
                            UIApplication.shared.open(settingURL) { (_) in}
                        }
                    }
                    alertController.addAction(goToSettings)
                    alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (_) in }))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
    func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y HH:mm"
        return formatter.string(from: date)
    }
}
