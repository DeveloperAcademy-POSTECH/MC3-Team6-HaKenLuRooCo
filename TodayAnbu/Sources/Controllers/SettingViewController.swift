//
//  DummyViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/18.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: Properties
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let personalMenu = ["요약", "가족 연락처", "알림", "토픽", "About us", "License"]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponent()
    }
    func configureViewComponent() {
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
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SettingPersonalDataCell else {
            return UITableViewCell()
        }
        cell.menuLable.text = personalMenu[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.layer.cornerRadius = 10
        return cell
    }

}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SettingHeaderView()
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
