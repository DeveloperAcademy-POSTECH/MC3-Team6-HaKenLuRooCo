//
//  TabbarController.swift
//  TodayAnbu
//
//  Created by 김연호 on 2022/07/25.
//

import UIKit
class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let firstTab = UINavigationController(rootViewController: MainViewController())
        let secondTab = UINavigationController(rootViewController: CallCheckViewController())
        secondTab.navigationBar.isHidden = true
        firstTab.tabBarItem.image = UIImage(systemName: "house")
        firstTab.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        secondTab.tabBarItem.image = UIImage(systemName: "book")
        secondTab.tabBarItem.selectedImage = UIImage(systemName: "book.fill")

        setViewControllers([firstTab, secondTab], animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
