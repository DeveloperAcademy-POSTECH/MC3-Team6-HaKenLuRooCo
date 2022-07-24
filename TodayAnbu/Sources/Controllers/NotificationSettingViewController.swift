//
//  NotificationSettingViewController.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/19.
//  Fixed by Lumi on 2022/07/20
//
import UIKit

class NotificationSettingViewController: UIViewController {

    private var notificationButtonList: [NotificationButton] = []
    private let weekDays = NotificationTime.setDummyData()
    // buttonIndex가 바뀔 때 마다 didset 이하 함수를 call
    private var buttonIndex: Int = 0 {
        didSet {
            horizontalStack.subviews.forEach({ $0.removeFromSuperview() })
            addSubViewNotificationButton()
            horizontalStack.subviews[buttonIndex].backgroundColor = .systemBlue
        }
    }

    private let horizontalStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setHStackViewConstraints()
        makeNotificationButtonList()
        addSubViewNotificationButton()
    }

    // 버튼을 담을 Hstack의 레이아웃을 설정함
    private func setHStackViewConstraints() {
        self.view.addSubview(horizontalStack)
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
