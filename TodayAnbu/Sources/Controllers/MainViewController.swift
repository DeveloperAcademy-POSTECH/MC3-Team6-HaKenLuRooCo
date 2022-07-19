//
//  MainViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/18.
//  혹시 몰라 통합용 베이스 MainViewController 생성했습니다.

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    lazy var rightButton: UIBarButtonItem = {
        let buttonImage: UIImage = UIImage(systemName: "person.circle")!
        let button = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(buttonPressed))
        return button
    }()
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitle()
        view.backgroundColor = .systemGray5
        navigationItem.rightBarButtonItem = self.rightButton
    }
    // 네비게이션 타이틀을 다루기 위해 정의된 메소드
    func initTitle() {
        let label = UILabel()
        label.textColor = .black
        label.text = "전화 안 한지 7일"
        label.font = .boldSystemFont(ofSize: 25)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }
    @objc private func buttonPressed(_ sender: Any) {
        let viewController = SettingViewController()
        self.present(viewController, animated: true)
    }
}
