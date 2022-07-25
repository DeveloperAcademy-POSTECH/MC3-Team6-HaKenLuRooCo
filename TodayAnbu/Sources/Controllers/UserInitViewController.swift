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
    
    private var notificationGuideText: UILabel = {
        let label = UILabel()
        label.text = "알람은 한 주에 최대 세번까지 설정할 수 있어요!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private var notificationButtonList: [NotificationButton] = []
    private let weekDays = NotificationTime.setDummyData()
    private let horizontalStack = UIStackView()
    private let notificationTimeSettingText: UILabel = {
        let label = UILabel()
        label.text = "언제 안부전화 알람을 드릴까요?"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    // 버튼을 탭했을때, 탭한 버튼에 나타나는 변화들
    private var buttonIndex: Int = 0 {
        didSet {
            timePicker.isHidden = false
            horizontalStack.subviews.forEach({ $0.removeFromSuperview() })
            addNotificationTimeLabel(indexPath: buttonIndex, time: timeLabel.toString())
            addSubViewNotificationButton()
            horizontalStack.subviews[buttonIndex].backgroundColor = .systemBlue
            horizontalStack.subviews[buttonIndex].layer.borderWidth = 3
            horizontalStack.subviews[buttonIndex].layer.borderColor = CGColor(red: 255, green: 255, blue: 0, alpha: 0)
        }
    }

    // 데이트 피커를 움직였을 때 나타나는 변화
    lazy private var timeLabel = timePicker.date {
        didSet {
            notificationButtonList[buttonIndex].notificationTime = timeLabel
            
            if timeLabel.toString().isEmpty {
                addNotificationTimeLabel(indexPath: buttonIndex, time: timeLabel.toString())
            } else {
                removeTimeLabel()
                addNotificationTimeLabel(indexPath: buttonIndex, time: timeLabel.toString())
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


        // 7무해 버튼 설정
        setHStackViewDefaultConstraints()
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
    @IBAction func timePickerAction(_ sender: UIDatePicker!) {
        timeLabel = sender.date
    }

}

extension UserInitViewController {

    // 버튼을 담을 Hstack의 레이아웃을 설정함
    private func setHStackViewDefaultConstraints() {
        momDayVstack.addSubview(notificationTimeSettingText)
        notificationTimeSettingText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationTimeSettingText.topAnchor.constraint(equalTo: momDayVstack.topAnchor, constant: 10),
            notificationTimeSettingText.leftAnchor.constraint(equalTo: momDayVstack.leftAnchor, constant: 5)
        ])
        
        momDayVstack.addSubview(notificationGuideText)
        notificationGuideText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationGuideText.topAnchor.constraint(equalTo: notificationTimeSettingText.topAnchor, constant: 35),
            notificationGuideText.leftAnchor.constraint(equalTo: momDayVstack.leftAnchor, constant: 5)
        ])

        momDayVstack.addSubview(horizontalStack)
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .equalSpacing
        horizontalStack.spacing = 5
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: notificationTimeSettingText.topAnchor, constant: 75),
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
        notificationButtonList[buttonIndex].buttonStack.arrangedSubviews[1].removeFromSuperview()
    }

    // 데이트 피커가 설정한 시간에 따라 타임 레이블을 추가하는 함수
    private func addNotificationTimeLabel(indexPath: Int, time: String) {
        let timeLabel: UILabel = {
            let label = UILabel()
            label.text = time
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.textColor = .white
            return label
        }()
        
        if notificationButtonList[indexPath].buttonStack.subviews.count != 2 {
        notificationButtonList[indexPath].buttonStack.addArrangedSubview(timeLabel)
        notificationButtonList[indexPath].buttonStack.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 3)
        } else if notificationButtonList[indexPath].isSelected && notificationButtonList[indexPath].buttonStack.subviews.count == 2 {
            notificationButtonList[indexPath].buttonStack.subviews[1].removeFromSuperview()
            notificationButtonList[indexPath].buttonStack.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        }
    }
    // 알람 설정 버튼의 속성을 설정하고, 배열을 만듬
    private func makeNotificationButtonList() {

        for index in 0...weekDays.count-1 {

            let dayButton = UIStackView()
            dayButton.axis = .vertical
            dayButton.alignment = .center
            dayButton.spacing = 5
            dayButton.layer.cornerRadius = 10
            dayButton.isLayoutMarginsRelativeArrangement = true
            dayButton.translatesAutoresizingMaskIntoConstraints = false
            let notificationButton = NotificationButton(id: index, buttonStack: dayButton, isSelected: false, notificationTime: Date())

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

//    private func showTimePicker() {
//        let notificationSettingView = NotificationModalViewController()
//        self.present(notificationSettingView, animated: true)
//    }

    @objc func setIndex(_ recognizer: UITapGestureRecognizer!) {
        buttonIndex = recognizer.view!.tag
        notificationButtonList[buttonIndex].isSelected.toggle()

        if notificationButtonList[buttonIndex].isSelected {
            notificationButtonList[buttonIndex].buttonStack.backgroundColor = .systemBlue
//            showTimePicker()
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

