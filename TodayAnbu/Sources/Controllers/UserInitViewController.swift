//
//  SettingViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/14.
//

import UIKit

class UserInitViewController: NotificationSettingViewController, UITextFieldDelegate {

    @IBOutlet weak var momVstackView: UIStackView! // 어머니 전화번호 입력 Vstack
    @IBOutlet weak var dadVstackView: UIStackView! // 아버지 전화번호 입력 Vstack
    @IBOutlet weak var momDayVstack: UIStackView! // 어머니 전화번호 입력 Vstack
    @IBOutlet weak var dadDayVstack: UIStackView! // 아버지 전화번호 입력 Vstack
    @IBOutlet weak var momNumberTextfield: UITextField! // 어머니 전화번호 입력 텍스트 필드
    @IBOutlet weak var dadNumberTextfield: UITextField! // 아버지 전화번호 입력 텍스트 필드
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var momSevenButtonHStack: UIStackView!
    @IBOutlet weak var dadSevenButtonHStack: UIStackView!

    // TODO : UserDefaults에 저장해야함.
    private var momPhoneNumber: String? = ""
    private var dadPhoneNumber: String? = ""

    private var notificationButtonList: [NotificationButton] = []
    private var buttonIndex: Int = 0
    let weekDays = NotificationTime.setDummyData()

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
        makeNotificationButtonList()
        addSubViewToMomStack()
//        addSubViewToDadStack()
        dadDayVstack.isHidden = true
        momDayVstack.isHidden = true
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
        if textField == momNumberTextfield {
            if momNumberTextfield.hasValidPhoneNumber && momNumberTextfield.text!.count == 11 {
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
            if dadNumberTextfield.hasValidPhoneNumber && dadNumberTextfield.text!.count == 11 {
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

    private func makeNotificationButtonList() {
        for index in 0...weekDays.count-1 {
            let buttonStack = UIStackView()

            let notificationButton = NotificationButton(id: index, buttonStack: buttonStack, isSelected: false)
            notificationButton.buttonStack.axis = .vertical
            notificationButton.buttonStack.alignment = .center
            notificationButton.buttonStack.spacing = 5
            notificationButton.buttonStack.layer.cornerRadius = 10
            notificationButton.buttonStack.isLayoutMarginsRelativeArrangement = true
            notificationButton.buttonStack.translatesAutoresizingMaskIntoConstraints = false
            notificationButton.buttonStack.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let firstLabel: UILabel = {
                let label = UILabel()
                label.text = weekDays[index].weekDay as? String
                label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                label.textColor = .white
                return label
            }()

            notificationButton.buttonStack.tag = index
            notificationButton.buttonStack.backgroundColor = .systemGray
            notificationButton.buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex(_:))))
            notificationButton.buttonStack.addArrangedSubview(firstLabel)
            notificationButtonList.append(notificationButton)
        }
    }

    private func addSubViewToMomStack() {
        for button in notificationButtonList {
            button.buttonStack.heightAnchor.constraint(equalToConstant: 60).isActive = true
            momSevenButtonHStack.addArrangedSubview(button.buttonStack)
        }
    }

    private func addSubViewToDadStack() {
        for button in notificationButtonList {
            button.buttonStack.heightAnchor.constraint(equalToConstant: 60).isActive = true
            dadSevenButtonHStack.addArrangedSubview(button.buttonStack)
        }
    }

    private func showTimePicker() {
        let notificationSettingView = NotificationModalViewController()
        self.present(notificationSettingView, animated: true)
    }

    @objc func setIndex(_ recognizer: UITapGestureRecognizer!) {
        print(notificationButtonList.map({$0.indexPath}))
        print(recognizer.view!.tag)
        buttonIndex = recognizer.view!.tag
        notificationButtonList[buttonIndex].isSelected.toggle()
        if notificationButtonList[buttonIndex].isSelected {
            notificationButtonList[buttonIndex].buttonStack.backgroundColor = .systemBlue
        } else {
            notificationButtonList[buttonIndex].buttonStack.backgroundColor = .systemGray
        }
        if notificationButtonList[buttonIndex].isSelected {
            showTimePicker()
        }
    }
}
