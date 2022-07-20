//
//  SettingViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/14.
//

import UIKit

class UserInitViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var momVstackView: UIStackView! // 어머니 전화번호 입력 Vstack
    @IBOutlet weak var dadVstackView: UIStackView! // 아버지 전화번호 입력 Vstack
    @IBOutlet weak var momDayVstack: UIStackView! // 어머니 전화번호 입력 Vstack
    @IBOutlet weak var dadDayVstack: UIStackView! // 아버지 전화번호 입력 Vstack
    @IBOutlet weak var momNumberTextfield: UITextField! // 어머니 전화번호 입력 텍스트 필드
    @IBOutlet weak var dadNumberTextfield: UITextField! // 아버지 전화번호 입력 텍스트 필드
    @IBOutlet weak var startButton: UIButton!

    // TODO : UserDefaults에 저장해야함.
    private var momPhoneNumber: String? = ""
    private var dadPhoneNumber: String? = ""

    // Delegate 설정 및 Textfield 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("", forKey: "momPhoneNumber")
        UserDefaults.standard.set("", forKey: "dadPhoneNumber")
        momNumberTextfield.delegate = self
        dadNumberTextfield.delegate = self
        momNumberTextfield.setBottomBorder(color: UIColor.systemGray4)
        momNumberTextfield.addDoneButtonOnKeyboard()
        dadNumberTextfield.setBottomBorder(color: UIColor.systemGray4)
        dadNumberTextfield.addDoneButtonOnKeyboard()
        momDayVstack.isHidden = true
        dadDayVstack.isHidden = true
        startButton.isEnabled = false
    }

    @IBAction func startButttonAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isFisrtLogin") // 최초 로그인인지 확인
        if momNumberTextfield.hasValidPhoneNumber {
            UserDefaults.standard.set(momNumberTextfield.text!, forKey: "momPhoneNumber")
        }
        if dadNumberTextfield.hasValidPhoneNumber {
            UserDefaults.standard.set(dadNumberTextfield.text!, forKey: "dadPhoneNumber")
        }
    }
}

extension UserInitViewController {
    // 텍스트 필드 validation check
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.hasValidPhoneNumber {
            textField.setBottomBorder(color: UIColor.systemBlue)
        } else {
            textField.setBottomBorder(color: UIColor.red)
        }

        if textField.text!.count < 12 {
            if textField == momNumberTextfield {
                momDayVstack.isHidden = true
            } else {
                dadDayVstack.isHidden = true
            }
        }
        let validation = textField.text!.count + string.count - range.length
        return !(validation > 11)
    }

    // textfield keyboard가 내려가면 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text!)
        print(textField.hasValidPhoneNumber)
        if textField == momNumberTextfield {
            if momNumberTextfield.text != nil && momNumberTextfield.hasValidPhoneNumber && momNumberTextfield.text!.count == 11 {
                textField.setBottomBorder(color: UIColor.systemBlue)
                startButton.isEnabled = true
                startButton.backgroundColor = UIColor.systemBlue
                momDayVstack.isHidden = false
            } else {
                print("momNumber Error")
                textField.setBottomBorder(color: UIColor.red)
                startButton.isEnabled = false
                startButton.backgroundColor = UIColor.systemGray4
                momDayVstack.isHidden = true

            }
        } else {
            if dadNumberTextfield.text != nil && dadNumberTextfield.hasValidPhoneNumber && dadNumberTextfield.text!.count == 11 {
                startButton.isEnabled = true
                startButton.backgroundColor = UIColor.systemBlue
                dadDayVstack.isHidden = false
            } else {
                print("dadNumber Error")
                startButton.isEnabled = false
                startButton.backgroundColor = UIColor.systemGray4
                dadDayVstack.isHidden = true
            }
        }
    }
}
