//
//  OnboardingMainVIewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/27.
//

import Foundation
import UIKit

class OnboardingMainVIewController: UIViewController {

    @IBOutlet var momSettingButton: UIButton!
    @IBOutlet var dadSettingButton: UIButton!

    private var isMomSelected: Bool = false
    private var isDadSelected: Bool = false

    override func viewDidLoad() {
        momSettingButton.layer.cornerRadius = 5
        dadSettingButton.layer.cornerRadius = 5
        momSettingButton.backgroundColor = UIColor.systemGray5
        dadSettingButton.backgroundColor = UIColor.systemGray5
    }

    // 어머니와 연락 설정하기 버튼 액션 함수
    // TODO: 추후 로직 수정 필요
    @IBAction func momSettingButtonAction(_ sender: Any) {
        isMomSelected.toggle()
        if isMomSelected {
            momSettingButton.backgroundColor = UIColor.momDeepPink
        } else {
            momSettingButton.backgroundColor = UIColor.systemGray5
        }
    }

    // 아버지와 연락 설정하기 버튼 액션 함수
    // TODO: 추후 로직 수정 필요
    @IBAction func dadSettingButtonAction(_ sender: Any) {
        isDadSelected.toggle()
        if isDadSelected {
            dadSettingButton.backgroundColor = .dadDeepSkyblue
        } else {
            dadSettingButton.backgroundColor = .systemGray5
        }
    }
}
