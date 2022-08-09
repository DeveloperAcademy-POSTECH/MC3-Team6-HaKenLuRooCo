//
//  SettingViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/15.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: Properties
    let switchOnAndOff = UISwitch()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let personalMenu = ["어머니 설정", "아버지 설정", "알림", "About Us"]
    let tableViewSection: [String] = ["설정", "추가정보"]

    private let tableCellHeader: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .systemGray
        return label
    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponent()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = true
    }

    func configureViewComponent() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonAction(_:)))

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingPersonalDataCell.self, forCellReuseIdentifier: "Cell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    @objc func changedSwitch(_ sender: UISwitch) {
        print(sender.isOn)
        if !sender.isOn {
            removeLocalNotifications()
            let notificationAlert = UIAlertController(title: "알람 비활성화", message: "원래 설정한 알람을 중단할게요! ", preferredStyle: .alert)
            notificationAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            }))
            self.present(notificationAlert, animated: true)

        } else {
            let notificationCenter = UNUserNotificationCenter.current()
            let userDefaultsData = UserDefaults.standard

            let momDateList = userDefaultsData.object(forKey: "Mom-FirstSetting-dateList") as? [Date] ?? [Date()]
            let momDayList = userDefaultsData.object(forKey: "Mom-FirstSetting-dayList") as? [Int] ?? [0]

            let dadDateList = userDefaultsData.object(forKey: "Dad-FirstSetting-dateList") as? [Date] ?? [Date()]
            let dadDayList = userDefaultsData.object(forKey: "Dad-FirstSetting-dayList") as? [Int] ?? [0]

            let dateList: [Date] = momDateList + dadDateList
            let dayList: [Int] = momDayList + dadDayList

            notificationCenter.getNotificationSettings { settings in
                DispatchQueue.main.async {
                    let title = "어머니에게 안부 전화드려보세요!"
                    let message = "오늘의 토픽 주제로 이야기해봐요!"

                    if settings.authorizationStatus == .authorized {
                        let content = UNMutableNotificationContent()
                        content.title = title
                        content.body = message

                        if dayList.isEmpty == false {
                            var requestNumber = 0
                            for index in 0...dayList.count-1 {
                                var dateComponent = Calendar.autoupdatingCurrent.dateComponents([.hour, .minute], from: dateList[index])

                                let weekDay: Int = {
                                    var weekDay = dayList[index] + 2
                                    if weekDay == 8 {
                                        weekDay = 1
                                    }
                                    return weekDay
                                }()

                                dateComponent.weekday = weekDay

                                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                notificationCenter.add(request) { error in
                                    if error != nil {
                                        print("Error " + error.debugDescription)
                                        return
                                    }
                                }
                                requestNumber += 1

                                print("RE: request에 요청된 날짜 정보는 다음과 같습니다. \(dateComponent)") // Test
                                print("RE: notification center에 요청된 정보는 다음과 같습니다 \(request)") // Test

                                print("총 전송된 request의 개수는 다음과 같습니다. \(requestNumber)")
                            }
                        } else {
                            let notificationAlert = UIAlertController(title: "알람을 설정하지 않으셨나요?", message: "알람은 설정창에서 바꿀 수 있어요! ", preferredStyle: .alert)
                            notificationAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            }))
                            self.present(notificationAlert, animated: true)
                        }

                        let notificationAlert = UIAlertController(title: "알람 재활성화", message: "원래 설정했던 대로 다시 알람을 드릴게요! ", preferredStyle: .alert)
                        notificationAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        }))
                        self.present(notificationAlert, animated: true)

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
                        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (_) in
                        }))
                        self.present(alertController, animated: true)
                    }
                }
            }
        }
    }

    @objc func doneButtonAction(_ sender: UIButton!) {
        self.dismiss(animated: true)
    }

    func removeLocalNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests -> Void in
                print("현재 설정된 request의 개수 \(requests.count)")
                for request in requests {
                    let notifIdentifier: String = request.identifier as String
                    print("삭제될 request: \(notifIdentifier)")
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notifIdentifier])
                }
            })
            UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { deliveredNotifications -> Void in
                print("\(deliveredNotifications.count) Delivered notifications-------")
                for notification in deliveredNotifications {
                    let notifIdentifier: String = notification.request.identifier as String
                    print("notifIdentifier deleted: \(notifIdentifier)")
                    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notifIdentifier])
                }
            })
        } else { // for iOS < 10
            let app: UIApplication = UIApplication.shared
            for oneEvent in app.scheduledLocalNotifications! {
                print("oneEvent Deleted ======================= \(oneEvent)")
                let notification = oneEvent as UILocalNotification
                app.cancelLocalNotification(notification)
            }
        }
    }

}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SettingPersonalDataCell else {
            return UITableViewCell()
        }
        cell.menuLable.text = personalMenu[indexPath.row]
        switch indexPath.row {
        case 2:
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(true, animated: true)
            switchView.addTarget(self, action: #selector(changedSwitch), for: .valueChanged)
            cell.accessoryView = switchView
        default:
            cell.accessoryType = .disclosureIndicator
        }
        cell.layer.cornerRadius = 10
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalMenu.count
    }
    // Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableCellHeader
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("지금 \(indexPath.row) 선택")
        switch indexPath.row {
        case 0:
            let userinitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MomInitViewController")
            self.navigationController?.pushViewController(userinitViewController, animated: true)
        case 1:
            let userinitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DadInitViewController")
            self.navigationController?.pushViewController(userinitViewController, animated: true)
        case 3:
            let aboutUsViewController = UIStoryboard(name: "AboutUsView", bundle: nil).instantiateViewController(withIdentifier: "AboutUsViewController")
            self.navigationController?.pushViewController(aboutUsViewController, animated: true)
        default :
            print("몰라")
        }
    }
}
