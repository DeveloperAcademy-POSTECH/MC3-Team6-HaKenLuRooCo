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

//        let firstTab = UINavigationController(rootViewController: MainViewController())
        let firstTab = MainViewController()
        let memoVC = UIStoryboard(name: "MemoStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MemoViewController")
        let secondTab = UINavigationController(rootViewController: memoVC)

        firstTab.tabBarItem.title = "안부"
        firstTab.tabBarItem.image = UIImage(systemName: "house")
        firstTab.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
//        firstTab.isNavigationBarHidden = true

        secondTab.tabBarItem.title = "메모"
        secondTab.tabBarItem.image = UIImage(systemName: "book")
        secondTab.tabBarItem.selectedImage = UIImage(systemName: "book.fill")

        setViewControllers([firstTab, secondTab], animated: true)
    }
}
