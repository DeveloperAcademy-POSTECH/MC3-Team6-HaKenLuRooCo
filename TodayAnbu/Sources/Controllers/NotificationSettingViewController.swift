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

    private var buttonIndex: Int = 0 {
        didSet {
            initialHStackView.subviews.forEach({ $0.removeFromSuperview() })
            addSubViewNotificationButton()
            initialHStackView.subviews[buttonIndex].backgroundColor = .systemBlue
        }
    }

    private let initialHStackView = UIStackView()

    override func viewDidLoad() {

        super.viewDidLoad()
        setHStackViewConstraints()
        makeNotificationButtonList()
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

            notificationButton.buttonStack.tag = index
            notificationButton.buttonStack.backgroundColor = .systemGray
            notificationButton.buttonStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setIndex(_:))))
            notificationButton.buttonStack.addArrangedSubview(firstLabel)
            notificationButton.buttonStack.addArrangedSubview(secondLabel)
            notificationButtonList.append(notificationButton)
        }
    }

    private func addSubViewNotificationButton() {
        for button in notificationButtonList {
            button.buttonStack.heightAnchor.constraint(equalToConstant: 60).isActive = true
            initialHStackView.addArrangedSubview(button.buttonStack)
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
