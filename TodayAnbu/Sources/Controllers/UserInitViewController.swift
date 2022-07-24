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
    
    private var notificationButtonList: [NotificationButton] = []
    private let weekDays = NotificationTime.setDummyData()
    private let horizontalStack = UIStackView()
    private var buttonIndex: Int = 0 {
        didSet {
            horizontalStack.subviews.forEach({ $0.removeFromSuperview() })
            addSubViewNotificationButton()
            horizontalStack.subviews[buttonIndex].backgroundColor = .systemBlue
        }
    }

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
        startButton.layer.cornerRadius = 10
        self.navigationItem.setHidesBackButton(true, animated: true)
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
    // 버튼을 담을 Hstack의 레이아웃을 설정함
    private func setHStackViewConstraints() {
        self.momDayVstack.addSubview(horizontalStack)
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .equalSpacing
        horizontalStack.spacing = 5
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // 알람 설정 버튼의 속성을 설정하고, 리스트화시킴
    private func makeNotificationButtonList() {

        for index in 0...weekDays.count-1 {

            let dayButton = UIStackView()
            dayButton.axis = .vertical
            dayButton.alignment = .center
            dayButton.spacing = 5
            dayButton.layer.cornerRadius = 10
            dayButton.isLayoutMarginsRelativeArrangement = true
            dayButton.translatesAutoresizingMaskIntoConstraints = false
            dayButton.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let notificationButton = NotificationButton(id: index, buttonStack: dayButton, isSelected: false)

            let firstLabel: UILabel = {
                let label = UILabel()
                label.text = weekDays[index].weekDay as String
                label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                label.textColor = .white
                return label
            }()

            let secondLabel: UILabel = {
                let label = UILabel()
                label.text = "18:00"
                label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                label.textColor = .white
                return label
            }()
            
            notificationButton.buttonStack.addArrangedSubview(firstLabel)
            notificationButton.buttonStack.addArrangedSubview(secondLabel)

            notificationButton.buttonStack.tag = index
            notificationButton.buttonStack.backgroundColor = .systemGray
            notificationButton.buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex(_:))))
            
            notificationButtonList.append(notificationButton)
        }
    }

    private func addSubViewNotificationButton() {
        for button in notificationButtonList {
            horizontalStack.addArrangedSubview(button.buttonStack)
        }
    }

    private func showTimePicker() {
        let notificationSettingView = NotificationModalViewController()
        self.present(notificationSettingView, animated: true)
    }

    @objc func setIndex(_ recognizer: UITapGestureRecognizer!) {
        
        buttonIndex = recognizer.view!.tag
        notificationButtonList[buttonIndex].isSelected.toggle()
        
        if notificationButtonList[buttonIndex].isSelected {
            notificationButtonList[buttonIndex].buttonStack.backgroundColor = .systemBlue
            showTimePicker()
        } else {
            notificationButtonList[buttonIndex].buttonStack.backgroundColor = .systemGray
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
}
