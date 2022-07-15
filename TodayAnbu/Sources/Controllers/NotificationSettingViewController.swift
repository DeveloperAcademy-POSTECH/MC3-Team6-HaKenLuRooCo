//
//  NotificationSettingViewController.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/14.
//
import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    let notificationCenter = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) {
            (permissionGranted, error) in
            if !permissionGranted {
                print("Permission Denied")
            }
        }
    }
    @IBAction func scheduleAction(_ sender: Any) {
        notificationCenter.getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                let title = self.titleTF.text!
                let message = self.messageTF.text!
                let date = self.datePicker.date
                if (settings.authorizationStatus == .authorized) {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message
                    let dateComp = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    self.notificationCenter.add(request) { (error) in
                        if (error != nil) {
                            print("Error " + error.debugDescription)
                            return
                        }
                    }
                    let alertController = UIAlertController(title: "Notification Scheduled", message: "At " + self.formattedDate(date: date), preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                    self.present(alertController, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Enable Notifications?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Settings", style: .default) {
                        (_) in guard let setttingsURL = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                        if UIApplication.shared.canOpenURL(setttingsURL) {
                            UIApplication.shared.open(setttingsURL) { (_) in}
                        }
                    }
                    alertController.addAction(goToSettings)
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in}))
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
