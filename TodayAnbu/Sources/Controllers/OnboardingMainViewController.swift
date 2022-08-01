//
//  OnboardingMainVIewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/27.
//

import Foundation
import UIKit

class OnboardingMainViewController: UIViewController {

    @IBOutlet var momSettingButton: UIButton!
    @IBOutlet var dadSettingButton: UIButton!
    @IBOutlet var nextButton: UIButton! // 확인 버튼

    private var isMomSelected: Bool = false
    private var isDadSelected: Bool = false

    override func viewDidLoad() {

        super.viewDidLoad()

        momSettingButton.layer.cornerRadius = 5
        dadSettingButton.layer.cornerRadius = 5
        nextButton.layer.cornerRadius = 5

        momSettingButton.backgroundColor = UIColor.systemGray5
        dadSettingButton.backgroundColor = UIColor.systemGray5
        nextButton.backgroundColor = UIColor.systemGray5

        momSettingButton.setImage(UIImage(systemName: "circle"), for: .normal)

        dadSettingButton.setImage(UIImage(systemName: "circle"), for: .normal)
    }

    // 어머니와 연락 설정하기 버튼 액션 함수
    // TODO: 추후 로직 수정 필요
    @IBAction func momSettingButtonAction(_ sender: Any) {
        isMomSelected.toggle()
        if isMomSelected {
            momSettingButton.backgroundColor = UIColor.momDeepPink
            momSettingButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            nextButton.backgroundColor = UIColor.mainIndigo
        } else {
            momSettingButton.backgroundColor = UIColor.systemGray5
            momSettingButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }

    // 아버지와 연락 설정하기 버튼 액션 함수
    // TODO: 추후 로직 수정 필요
    @IBAction func dadSettingButtonAction(_ sender: Any) {
        isDadSelected.toggle()
        if isDadSelected {
            dadSettingButton.backgroundColor = .dadDeepSkyblue
            dadSettingButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)

            nextButton.backgroundColor = UIColor.mainIndigo

        } else {
            dadSettingButton.backgroundColor = .systemGray5
            dadSettingButton.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        // TODO: Action 추가해야함 추후 수정할 예정
    }

}
