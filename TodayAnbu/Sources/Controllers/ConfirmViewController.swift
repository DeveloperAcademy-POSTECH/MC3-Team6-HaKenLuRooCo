//
//  ConfirmViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/20.
//

import UIKit

class ConfirmViewController: UIViewController {

    // label 한개랑 버튼 두개 만들어야 함
    private let confirmLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "통화는 잘 하셨나요?"
        label.font = .boldSystemFont(ofSize: 35)
        return label
    }()
    private lazy var positiveButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("예", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(positiveButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var negativeButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("아니요", for: .normal)
        button.backgroundColor = .systemGray2
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(negativeButtonPressed), for: .touchUpInside)
        return button
    }()

    @objc func changeData(notification: NSNotification) {
        let testData = notification.object.self
        print("this is test Data \(testData ?? "테스트 데이터없음")")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        CallManager.shared.$data.sink {
            print($0)
        }
//        CallManager.shared.data.$isMomCall.sink { data in
//            print(CallManager.shared.data.isMomCall)
//        }
//        CallManager.shared.data.$isDadCall.sink { data in
//        }
    }

    func configureUI() {
        self.view.backgroundColor = .white
        view.addSubview(confirmLabel)
        view.addSubview(positiveButton)
        view.addSubview(negativeButton)
        confirmLabel.translatesAutoresizingMaskIntoConstraints = false
        positiveButton.translatesAutoresizingMaskIntoConstraints = false
        negativeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            positiveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            positiveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            positiveButton.heightAnchor.constraint(equalToConstant: 60),
            positiveButton.bottomAnchor.constraint(equalTo: negativeButton.topAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            negativeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            negativeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            negativeButton.heightAnchor.constraint(equalToConstant: 60),
            negativeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -130)
        ])
    }
    @objc func positiveButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("ConfirmView"), object: nil)
        if CallManager.shared.data.isMomCall {
            var currentData = CallManager.shared.data
            currentData.momCheckCount += 1
            currentData.isMomCall.toggle()
            CallManager.shared.data = currentData
        }

        if CallManager.shared.data.isDadCall {
            var currentData = CallManager.shared.data
            currentData.dadCheckCount += 1
            currentData.isMomCall.toggle()
            CallManager.shared.data.isDadCall.toggle()
        }
        self.dismiss(animated: true, completion: nil)
    }
    @objc func negativeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
