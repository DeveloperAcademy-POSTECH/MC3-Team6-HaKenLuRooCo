//
//  SettingViewController.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/14.
//  Revised by Rookie Since 2022/07/25

import UIKit

class MomInitViewController: UIViewController, UITextFieldDelegate {

    var numberOfSelected = 0
    @IBOutlet weak var momVstackView: UIStackView!
    @IBOutlet weak var momDayVstack: UIStackView!
    @IBOutlet weak var momNumberTextfield: UITextField!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!

    private let notificationCenter = UNUserNotificationCenter.current()
    private var notificationGuideText: UILabel = {
        let label = UILabel()
        label.text = "알람은 한 주에 최대 세번까지 설정할 수 있어요!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private var notificationButtonList: [NotificationButton] = []
    private let horizontalStack = UIStackView()
    private let notificationTimeSettingText: UILabel = {
        let label = UILabel()
        label.text = "언제 안부전화 알람을 드릴까요?"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let dot: UILabel = {
        let dot = UILabel()
        dot.text = "."
        dot.font = .boldSystemFont(ofSize: 30)
        dot.textColor = .activePinkColor
        return dot
    }()

    // 버튼을 탭했을때, 탭한 버튼에 나타나는 변화들
    private var buttonIndex: Int = 0 {

        didSet {
            timePicker.isHidden = false
            horizontalStack.subviews.forEach({ $0.removeFromSuperview() })
            addNotificationTimeLabel(indexPath: buttonIndex, time: timeLabel.toString())
            addSubViewNotificationButton()

            if notificationButtonList[buttonIndex].isSelected == false {
                let stack = horizontalStack.subviews[buttonIndex] as? UIStackView
                stack?.addArrangedSubview(dot)
            } else {

                horizontalStack.subviews[buttonIndex].layer.borderWidth = 0
            }
        }
    }

    // MARK: 데이트 피커를 움직였을 때 나타나는 변화
    lazy private var timeLabel = timePicker.date {
        didSet {
            print("현재 선택된 버튼의 개수는 다음과 같습니다 \(notificationButtonList.filter({$0.isSelected == true}).count)")
            if notificationButtonList.filter({$0.isSelected == true}).isEmpty == false {
                print("선택된 버튼이 있네요. 다음과 같습니다 button Index \(buttonIndex)")
                notificationButtonList[buttonIndex].notificationTime = timeLabel
                if timeLabel.toString().isEmpty {
                    addNotificationTimeLabel(indexPath: buttonIndex, time: timeLabel.toString())
                } else if notificationButtonList[buttonIndex].buttonStack.subviews.count == 2 {
                    removeTimeLabel()
                    addNotificationTimeLabel(indexPath: buttonIndex, time: timeLabel.toString())
                }
            }
        }
    }

    // UserDefault 세팅용
    private var momPhoneNumber: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        momNumberTextfield.delegate = self
        momNumberTextfield.setBottomBorder(color: UIColor.systemGray4)
        momNumberTextfield.addDoneButtonOnKeyboard()

        momDayVstack.isHidden = true
        startButton.isEnabled = false
        startButton.layer.cornerRadius = 10

        // 7개 알람 버튼 레이아웃 설정
        setHStackViewDefaultConstraints()
        makeNotificationButtonList()
        addSubViewNotificationButton()
        initializeButtonSize(size: 15)

        // time picker 설정
        timePicker.isHidden = true

        // notification 접근 허가 설정
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (permissionGranted, error) in
            if !permissionGranted {
                print("Permission Denied")
                print(error ?? "No error")
            }
        }
        //        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    @IBAction func startButttonAction(_ sender: Any) {
        if momNumberTextfield.hasValidPhoneNumber {
            UserDefaults.standard.set(momNumberTextfield.text!, forKey: "momPhoneNumber")
        }
    }
    @IBAction func timePickerAction(_ sender: UIDatePicker!) {
        timeLabel = sender.date
        print("이 값은 데이트 피커의 date 값입니다. \(sender.date)") // Test
    }
}

extension MomInitViewController {
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
        horizontalStack.alignment = .top
        horizontalStack.distribution = .equalSpacing
        horizontalStack.spacing = 5
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: notificationTimeSettingText.topAnchor, constant: 75),
            horizontalStack.centerXAnchor.constraint(equalTo: momDayVstack.centerXAnchor)
        ])
    }

    private func initializeButtonSize(size: CGFloat) {
        for button in notificationButtonList {
            button.buttonStack.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: size, leading: size, bottom: size, trailing: size)
        }
    }

    private func removeTimeLabel() {
        notificationButtonList[buttonIndex].buttonStack.arrangedSubviews[1].removeFromSuperview()
    }

    //MARK: 데이트 피커가 설정한 시간에 따라 타임 레이블을 추가하는 함수
    private func addNotificationTimeLabel(indexPath: Int, time: String) {
        let timeLabel: UILabel = {
            let label = UILabel()
            label.text = time
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.textColor = .white
            return label
        }()

        //MARK: 데이트 피커가 설정한 시간에 따라 타임 레이블을 추가하는 함수
        if notificationButtonList[indexPath].buttonStack.subviews.count != 2 {
            notificationButtonList[indexPath].buttonStack.addArrangedSubview(timeLabel)
            notificationButtonList[indexPath].buttonStack.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)

            //MARK: 알람 세팅된 버튼을 다시 클릭했을 경우
        } else if notificationButtonList[indexPath].isSelected && notificationButtonList[indexPath].buttonStack.subviews.count == 2 {
            notificationButtonList[indexPath].buttonStack.subviews[1].removeFromSuperview()
            notificationButtonList[indexPath].buttonStack.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
            notificationButtonList[indexPath].buttonStack.layer.borderWidth = 0
        }
    }

    // 알람 설정 버튼의 속성을 설정하고, 알람 버튼 배열을 만듬
    private func makeNotificationButtonList() {
        for index in 0...WeekDay.allCases.count-1 {
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
                label.text = WeekDay.allCases[index].rawValue
                label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                label.textColor = .white
                return label
            }()

            notificationButton.buttonStack.addArrangedSubview(firstLabel)
            notificationButton.buttonStack.tag = index
            notificationButton.buttonStack.backgroundColor = .systemGray3
            notificationButton.buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex(_:))))

            notificationButtonList.append(notificationButton)
        }
    }

    private func addSubViewNotificationButton() {
        for button in notificationButtonList {
            let vStack: UIStackView = {
                let stack = UIStackView()
                stack.axis = .vertical
                stack.alignment = .center
                stack.spacing = -16
                return stack
            }()

            vStack.addArrangedSubview(button.buttonStack)
            horizontalStack.addArrangedSubview(vStack)
        }
    }

    // MARK: 버튼 누르면 실행되는 함수
    @objc func setIndex(_ recognizer: UITapGestureRecognizer!) {

        if numberOfSelected < 3 {
            buttonIndex = recognizer.view!.tag
            notificationButtonList[buttonIndex].isSelected.toggle()
            if notificationButtonList[buttonIndex].isSelected {
                numberOfSelected += 1
            } else {
                numberOfSelected -= 1
            }

        } else {
            let tempButtonIndex = recognizer.view!.tag
            if notificationButtonList[tempButtonIndex].isSelected {
                buttonIndex = tempButtonIndex
                numberOfSelected -= 1
                notificationButtonList[tempButtonIndex].isSelected.toggle()
            }
        }

        if notificationButtonList[buttonIndex].isSelected {
            notificationButtonList[buttonIndex].buttonStack.backgroundColor = .momLightPink
        } else {
            notificationButtonList[buttonIndex].buttonStack.backgroundColor = .systemGray3
        }
    }
}

extension MomInitViewController {
    @IBAction func setNotificationTime(_ sender: Any) {
        var dateList: [Date] = []
        var dayList: [Int] = []
        for button in notificationButtonList where button.isSelected {
            dateList.append(button.notificationTime)
            dayList.append(button.indexPath)
        }

        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                let title = "어머니에게 안부 전화드려보세요!"
                let message = "오늘의 토픽 주제로 이야기해봐요!"

                if settings.authorizationStatus == .authorized {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = message

                    if dayList.isEmpty == false {
                        for index in 0...dayList.count-1 {
                            var dateComponent = Calendar.autoupdatingCurrent.dateComponents([.hour, .minute], from: dateList[index])
                            let weekDay: Int = {
                                var weekDay = dayList[index] + 2
                                if weekDay == 8 {
                                    weekDay = 1
                                }
                                return weekDay
                            }()
                            dateComponent.weekday = weekDay
                            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            self.notificationCenter.add(request) { error in
                                if error != nil {
                                    print("Error " + error.debugDescription)
                                    return
                                }
                            }
                            print("request에 요청된 날짜 정보는 다음과 같습니다. \(dateComponent)") // Test
                            print("notification center에 요청된 정보는 다음과 같습니다 \(request)") // Test
                        }
                    } else {
                        let notificationAlert = UIAlertController(title: "알람을 설정하지 않으셨나요?", message: "알람은 설정창에서 바꿀 수 있어요! ", preferredStyle: .alert)
                        notificationAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            self.dismiss(animated: true)
                        }))
                        self.present(notificationAlert, animated: true)
                    }

                    let notificationAlert = UIAlertController(title: "알람 설정완료!", message: "알람은 설정창에서 바꿀 수 있어요! ", preferredStyle: .alert)
                    notificationAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        self.dismiss(animated: true)
                    }))
                    self.present(notificationAlert, animated: true)

                    // notification 허용하지 않을 경우
                } else {
                    let alertController = UIAlertController(title: "알림을 설정하시겠어요?", message: "설정에서 알람 허용을 해주셔야해요!", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "설정", style: .default) { _ in
                        guard let settingURL = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        if UIApplication.shared.canOpenURL(settingURL) {
                            UIApplication.shared.open(settingURL) { (_) in}
                        }
                    }
                    alertController.addAction(goToSettings)
                    alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (_) in
                        self.dismiss(animated: true)
                    }))
                    self.present(alertController, animated: true)
                }
            }
        }
    }
}

extension MomInitViewController {
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
                startButton.backgroundColor = .mainIndigo
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
