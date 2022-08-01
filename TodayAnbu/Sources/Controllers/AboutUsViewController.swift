//
//  AboutUsViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/29.
//

import UIKit

class AboutUsViewController: UIViewController {

    // 각 하켄루루코 인원들 버튼
    @IBOutlet var hardyButton: UIButton!
    @IBOutlet var kenButton: UIButton!
    @IBOutlet var lumiButton: UIButton!
    @IBOutlet var rookieButton: UIButton!
    @IBOutlet var cozybutton: UIButton!

    @IBOutlet var topTitleBox: UIView! // 상단 제목 박스

    private var userURL: String = "https://github.com/DeveloperAcademy-POSTECH/MC3-Team6-HaKenLuRooCo"

    override func viewDidLoad() {
        super.viewDidLoad()
        topTitleBox.layer.cornerRadius = 20
        topTitleBox.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    // ViewController 호출, Data Passing, 화면 전환 순서
    private func sendURL(url: String) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "AboutUsWebViewController") as? AboutUsWebViewController else {
            return
        }
        viewController.userURL = url
        self.present(viewController, animated: true)
    }

    // Action : 1. 각 고유 URL저장, sendURL 호출
    @IBAction func hardyButtonAction(_ sender: Any) {
        userURL = "https://github.com/Kim-Yeon-ho"
        sendURL(url: userURL)
    }

    @IBAction func kenButtonAction(_ sender: Any) {
        userURL = "https://github.com/obtusa07"
        sendURL(url: userURL)
    }

    @IBAction func lumiButtonAction(_ sender: Any) {
        userURL = "https://github.com/luminouxx"
        sendURL(url: userURL)
    }

    @IBAction func rookieButtonAction(_ sender: Any) {
        userURL = "https://github.com/Rookie0031"
        sendURL(url: userURL)
    }

    @IBAction func cozyButtonAction(_ sender: Any) {
        userURL = "https://github.com/cozytk"
        sendURL(url: userURL)
    }
}
