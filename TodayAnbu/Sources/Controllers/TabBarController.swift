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
        let secondTab = UIStoryboard(name: "MemoStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MemoViewController")
        self.navigationController?.pushViewController(secondTab, animated: true)

        firstTab.tabBarItem.image = UIImage(systemName: "house")
        firstTab.tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        secondTab.tabBarItem.image = UIImage(systemName: "book")
        secondTab.tabBarItem.selectedImage = UIImage(systemName: "book.fill")

        setViewControllers([firstTab, secondTab], animated: true)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
