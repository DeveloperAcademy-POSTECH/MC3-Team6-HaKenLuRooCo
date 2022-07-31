//
//  OnboardingPageViewController.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/14.
//

import UIKit

class OnboardingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startButtonAction(_ sender: Any) {
        presentMainViewController()
    }

    private func presentMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarView")
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)
    }
}
