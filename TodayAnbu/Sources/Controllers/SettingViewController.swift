//
//  SettingViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/14.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var momNumberTF: UITextField!
    @IBOutlet weak var dadNumberTF: UITextField!

    override func viewDidLayoutSubviews() {
        momNumberTF.setBottomBorder(color: UIColor.systemGray4)
        momNumberTF.addDoneButtonOnKeyboard()
        dadNumberTF.setBottomBorder(color: UIColor.systemGray4)
        dadNumberTF.addDoneButtonOnKeyboard()
    }
    override func viewDidLoad() {

        super.viewDidLoad()
        print("Setting View Did Loaded")
    }
}
