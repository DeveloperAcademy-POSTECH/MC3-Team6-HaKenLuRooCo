//
//  AboutUsViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/29.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet var hardyButton: UIButton!
    @IBOutlet var kenButton: UIButton!
    @IBOutlet var lumiButton: UIButton!
    @IBOutlet var rookieButton: UIButton!
    @IBOutlet var cozybutton: UIButton!

    @IBOutlet var topTitleBox: UIView!

    private var userURL: String = "https://github.com/DeveloperAcademy-POSTECH/MC3-Team6-HaKenLuRooCo"

    override func viewDidLoad() {
        super.viewDidLoad()
        topTitleBox.layer.cornerRadius = 20
        topTitleBox.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    private func sendURL(url: String) {
        print("function call")
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "AboutUsWebViewController") as? AboutUsWebViewController else {
            print("vc 생성 실패")
            return

        }

        print(viewController)
        viewController.userURL = url
    }

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
