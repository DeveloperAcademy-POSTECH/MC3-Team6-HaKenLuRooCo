//
//  SettingViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/15.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: Properties
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
        settingTopArea.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SettingPersonalDataCell else {
            return UITableViewCell()
        }
        cell.menuLable.text = personalMenu[indexPath.row]
        cell.accessoryType = .disclosureIndicator
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
        let userinitViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserInitViewController")
        self.navigationController?.pushViewController(userinitViewController, animated: true)
    }
}
