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
    let personalMenu = ["어머니 설정", "아버지 설정", "알림"]
    let tableViewSection: [String] = ["설정", "추가정보"]

    private let settingTopArea: UIView = {
        let area = UIView()
        area.layer.cornerRadius = 20
        area.backgroundColor = .mainIndigo
        return area
    }()

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
    
    func configureViewComponent() {
        view.addSubview(tableView)
        view.addSubview(settingTopArea)
        // view.addSubview(switchOnAndOff)
        settingTopArea.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // switchOnAndOff.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingPersonalDataCell.self, forCellReuseIdentifier: "Cell")
        NSLayoutConstraint.activate([
            settingTopArea.topAnchor.constraint(equalTo: view.topAnchor),
            settingTopArea.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            settingTopArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingTopArea.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: settingTopArea.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    @objc func changedSwitch(_ sender: UISwitch) {
        print(sender.isOn)
        if !sender.isOn {
            removeLocalNotifications()
        }
//        let state = switchOnAndOff.isOn ? "On" : "Off"
//        print(state)
        
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
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = SettingHeaderView()
//        return header
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 300
//    }
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
        default :
            print("몰라")
        }
    }
}
