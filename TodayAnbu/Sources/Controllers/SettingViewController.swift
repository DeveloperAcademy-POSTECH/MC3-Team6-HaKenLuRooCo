//
//  SettingViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/14.
//

import Foundation
import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    var momNumber: String?
    var dadNumber: String?
    private var isMomNumberCompleted: Bool = false

    @IBOutlet weak var momNumberTF: UITextField! // 어머니 전화번호 입력 텍스트 필드
    @IBOutlet weak var dadNumberTF: UITextField! // 아버지 전화번호 입력 텍스트 필드

    override func viewDidLoad() {
        super.viewDidLoad()
        momNumberTF.delegate = self
        dadNumberTF.delegate = self
        momNumberTF.setBottomBorder(color: UIColor.systemGray4) // Textfield에 밑줄 추가
        momNumberTF.addDoneButtonOnKeyboard()
        dadNumberTF.setBottomBorder(color: UIColor.systemGray4)
        dadNumberTF.addDoneButtonOnKeyboard() // Keyboard에 done 버튼 추가
    }
    override func viewDidAppear(_ animated: Bool) {
        if isMomNumberCompleted == true {
            print("Good")
        }
    }
}

extension SettingViewController {
    //     텍스트 필드 validation check
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        if textField.text!.count < 10 {
            textField.setBottomBorder(color: UIColor.red)
        } else {
            textField.setBottomBorder(color: UIColor.green)
        }
        let validation = textField.text!.count + string.count - range.length
        return !(validation > 11)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == momNumberTF {
            if momNumberTF.text != nil {
                momNumber = momNumberTF.text!
                isMomNumberCompleted = true
                print(momNumber ?? "nil")
            } else {
                print("momNumber Error")
            }
        } else {
            if dadNumberTF.text != nil {
                dadNumber = dadNumberTF.text!
                print(dadNumber ?? "nil")
            } else {
                print("dadNumber Error")
            }
        }
    }
}
