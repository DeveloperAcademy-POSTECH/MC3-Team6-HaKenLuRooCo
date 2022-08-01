//
//  AboutUsWebViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/29.
//

import UIKit
import WebKit

class AboutUsWebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!

    var userURL: String = "https://github.com/DeveloperAcademy-POSTECH/MC3-Team6-HaKenLuRooCo"

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebPage(userURL)
    }

    private func loadWebPage(_ url: String) {
        guard let myUrl = URL(string: url) else {
            return
        }
        let request = URLRequest(url: myUrl)
        webView.load(request)
    }
}
