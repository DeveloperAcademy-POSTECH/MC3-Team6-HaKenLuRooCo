//
//  NotificationSettingViewController.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/19.
//
import UIKit

class NotificationSettingViewController: UIViewController {
    
    private var notificationButtonList: [NotificationButton] = []
    private var buttonIndex: Int = 0
    private var isButtonTapped = false {
        didSet {
            if isButtonTapped {
                initialHStackView.subviews.forEach({ $0.removeFromSuperview() })
                addSubViewNotificationButton()
                initialHStackView.subviews[buttonIndex].backgroundColor = .systemBlue
            } else {
                initialHStackView.subviews.forEach({ $0.removeFromSuperview() })
                addSubViewNotificationButton()
                initialHStackView.subviews[buttonIndex].backgroundColor = .systemGray
            }
        }
    }
    private let initialHStackView = UIStackView()
    private var buttonColor: UIColor = .systemGray

    override func viewDidLoad() {
        super.viewDidLoad()
        setHStackViewConstraints()
        addSubViewNotificationButton()
    }

    private func setHStackViewConstraints() {
        self.view.addSubview(initialHStackView)
        initialHStackView.axis = .horizontal
        initialHStackView.alignment = .center
        initialHStackView.distribution = .equalSpacing
        initialHStackView.spacing = 5
        initialHStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            initialHStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            initialHStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    let weekDays = NotificationTime.setDummyData()
    private func makeNotificationButtonList() -> [NotificationButton] {
        var notificationButtonList: [NotificationButton] = []
        for index in 0...weekDays.count-1 {

            let buttonStack = UIStackView()

            let notificationButton = NotificationButton(id: index, buttonStack: buttonStack)
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

            let secondLabel: UILabel = {
                let label = UILabel()
                label.text = "18:00"
                label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                label.textColor = .white
                return label
            }()
            notificationButton.buttonStack.backgroundColor = buttonColor
            notificationButton.buttonStack.addArrangedSubview(firstLabel)
            notificationButton.buttonStack.addArrangedSubview(secondLabel)
            notificationButtonList.append(notificationButton)

            self.notificationButtonList = notificationButtonList
        }
        addTapGesture()
        return notificationButtonList
    }

    private func addTapGesture() {

        notificationButtonList[0].buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex0(_:))))

        notificationButtonList[1].buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex1(_:))))

        notificationButtonList[2].buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex2(_:))))

        notificationButtonList[3].buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex3(_:))))

        notificationButtonList[4].buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex4(_:))))

        notificationButtonList[5].buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex5(_:))))

        notificationButtonList[6].buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex6(_:))))

    }

    private func addSubViewNotificationButton() {
        let notificationButtonList = makeNotificationButtonList()
        for button in notificationButtonList {
            initialHStackView.addArrangedSubview(button.buttonStack)
        }
    }

    private func showTimePicker() {
        let notificationSettingView = NotificationModalViewController()
        self.present(notificationSettingView, animated: true)
    }

    @objc func setIndex0(_ sender: UIStackView!) {
        buttonIndex = 0
        showTimePicker()
        isButtonTapped.toggle()
        print("현재 선택된 버튼의 인덱스는 \(buttonIndex) 입니다")
    }

    @objc func setIndex1(_ sender: UIStackView!) {
        buttonIndex = 1
        showTimePicker()
        isButtonTapped.toggle()
        print("현재 선택된 버튼의 인덱스는 \(buttonIndex) 입니다")
    }

    @objc func setIndex2(_ sender: UIStackView!) {
        buttonIndex = 2
        showTimePicker()
        isButtonTapped.toggle()
        print("현재 선택된 버튼의 인덱스는 \(buttonIndex) 입니다")
    }

    @objc func setIndex3(_ sender: UIStackView!) {
        buttonIndex = 3
        showTimePicker()
        print("현재 선택된 버튼의 인덱스는 \(buttonIndex) 입니다")
    }

    @objc func setIndex4(_ sender: UIStackView!) {
        buttonIndex = 4
        showTimePicker()
        print("현재 선택된 버튼의 인덱스는 \(buttonIndex) 입니다")
    }

    @objc func setIndex5(_ sender: UIStackView!) {
        buttonIndex = 5
        showTimePicker()
        print("현재 선택된 버튼의 인덱스는 \(buttonIndex) 입니다")
    }

    @objc func setIndex6(_ sender: UIStackView!) {
        buttonIndex = 6
        showTimePicker()
        print("현재 선택된 버튼의 인덱스는 \(buttonIndex) 입니다")
    }
}

class NotificationButton {
    var indexPath: Int
    var buttonStack: UIStackView
    init(id: Int, buttonStack: UIStackView) {
        self.indexPath = 0
        self.buttonStack = buttonStack
    }
}

struct ButtonData {
    var weekDay: String
    var time: String
}
