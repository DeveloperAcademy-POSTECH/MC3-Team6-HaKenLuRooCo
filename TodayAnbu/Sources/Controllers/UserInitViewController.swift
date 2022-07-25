//
//  SettingViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/14.
//

import UIKit

import UIKit

class UserInitViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var momVstackView: UIStackView!
    @IBOutlet weak var momDayVstack: UIStackView!
    @IBOutlet weak var momNumberTextfield: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!

    private var notificationButtonList: [NotificationButton] = []
    private let weekDays = NotificationTime.setDummyData()
    private let horizontalStack = UIStackView()
    private let alarmText: UILabel = {
        let label = UILabel()
        label.text = "언제 알람을 드릴까요?"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private var buttonIndex: Int = 0 {
        didSet {
            horizontalStack.subviews.forEach({ $0.removeFromSuperview() })
            addSubViewNotificationButton()
            horizontalStack.subviews[buttonIndex].backgroundColor = .systemBlue
            addNotiTimeLabel(time: timeLabel)
        }
    }

    lazy private var timeLabel = timePicker.date.toString() {
        didSet {
            if timeLabel.isEmpty {
            addNotiTimeLabel(time: timeLabel)
            } else {
                removeTimeLabel()
                addNotiTimeLabel(time: timeLabel)
            }
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
        momNumberTextfield.setBottomBorder(color: UIColor.systemGray4)
        momNumberTextfield.addDoneButtonOnKeyboard()

        momDayVstack.isHidden = true
        startButton.isEnabled = false
        startButton.layer.cornerRadius = 10

        momDayVstack.isHidden = true
        startButton.isEnabled = false
        startButton.layer.cornerRadius = 10

        // 7무해 버튼 설정
        setHStackViewConstraints()
        makeNotificationButtonList()
        addSubViewNotificationButton()
        buttonSizeControl(size: 15)

        // time picker 설정
        timePicker.isHidden = true

        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    @IBAction func startButttonAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isFisrtLogin") // 최초 로그인인지 확인
        if momNumberTextfield.hasValidPhoneNumber {
            UserDefaults.standard.set(momNumberTextfield.text!, forKey: "momPhoneNumber")
        }
    }
    @IBAction func timePickerAction(_ sender: Any) {
        var time = timePicker.date.toString()
        timeLabel = time
    }
}

extension UserInitViewController {

    // 버튼을 담을 Hstack의 레이아웃을 설정함
    private func setHStackViewConstraints() {
        momDayVstack.addSubview(alarmText)
        alarmText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alarmText.topAnchor.constraint(equalTo: momDayVstack.topAnchor, constant: 10),
            alarmText.leftAnchor.constraint(equalTo: momDayVstack.leftAnchor, constant: 5)
        ])

        momDayVstack.addSubview(horizontalStack)
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .equalSpacing
        horizontalStack.spacing = 5
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: alarmText.topAnchor, constant: 40),
            horizontalStack.centerXAnchor.constraint(equalTo: momDayVstack.centerXAnchor)
        ])

        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
    }

    private func buttonSizeControl(size: CGFloat) {
        for button in notificationButtonList {
            button.buttonStack.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: size, leading: size, bottom: size, trailing: size)
        }
    }

    private func removeTimeLabel() {
        notificationButtonList[2].buttonStack.arrangedSubviews[1].removeFromSuperview()
    }

    private func addNotiTimeLabel(time: String) {
        let timeLabel: UILabel = {
            let label = UILabel()
            label.text = time
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.textColor = .white
            return label
        }()
        notificationButtonList[2].buttonStack.addArrangedSubview(timeLabel)
        notificationButtonList[2].buttonStack.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: 5, leading: 3, bottom: 5, trailing: 3)
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
            let notificationButton = NotificationButton(id: index, buttonStack: dayButton, isSelected: false)

            let firstLabel: UILabel = {
                let label = UILabel()
                label.text = weekDays[index].weekDay as String
                label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                label.textColor = .white
                return label
            }()

            notificationButton.buttonStack.addArrangedSubview(firstLabel)
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
            timePicker.isHidden.toggle()
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
        }
    }
}

