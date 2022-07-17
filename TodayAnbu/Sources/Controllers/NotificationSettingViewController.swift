//
//  NotificationSettingViewController.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/14.
//
import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    let notificationCenter = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (permissionGranted, _) in
            if !permissionGranted {
                print("Permission Denied")
            }
        }
    }
    // 알람 설정 버튼과 연동해야함, Completion Feedback(진동,소리)은 버튼 애니메이션과 파란색 활성화로 대체
    @IBAction func scheduleAction(_ sender: Any) { notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                let title = self.textField.text!
                let message = self.messageTF.text!
                let date = self.datePicker.date
                if settings.authorizationStatus == .authorized {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
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
                        guard let setttingsURL = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                        if UIApplication.shared.canOpenURL(setttingsURL) {
                            UIApplication.shared.open(setttingsURL) { (_) in}
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
