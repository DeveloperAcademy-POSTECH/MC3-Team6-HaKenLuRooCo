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

    override func viewDidLoad() {
        super.viewDidLoad()
        topTitleBox.layer.cornerRadius = 20
        topTitleBox.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    @IBAction func hardyButtonAction(_ sender: Any) {
        
    }

    @IBAction func kenButtonAction(_ sender: Any) {
    }

    @IBAction func lumiButtonAction(_ sender: Any) {
    }

    @IBAction func rookieButtonAction(_ sender: Any) {
    }

    @IBAction func cozyButtonAction(_ sender: Any) {
    }
    
}
