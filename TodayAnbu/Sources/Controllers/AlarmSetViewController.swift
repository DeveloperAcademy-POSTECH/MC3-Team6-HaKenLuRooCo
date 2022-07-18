//
//  AlarmSetViewController.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/18.
//

import UIKit

class AlarmSetViewController: UIViewController {
    private var isStarted = false
    private var isStackViewTapped = false
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    let testLabelSecond: UILabel = {
        let label = UILabel()
        label.text = "18:00"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        return label
    }()
    let stackView = UIStackView()
    let testStackView = UIStackView()
    let buttonStackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonToStackView()
        setStackViewConstraints()
        setTestStackViewConstraints()
    }
    
    private func setStackViewConstraints() {
        self.view.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
    }
    private func setTestStackViewConstraints() {
        self.view.addSubview(testStackView)
        testStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(testStackViewTapped(_:))))
        testStackView.axis = .vertical
        testStackView.alignment = .center
        testStackView.spacing = 5
        testStackView.backgroundColor = isStackViewTapped ? .systemBlue : .gray
        testStackView.layer.cornerRadius = 10
        testStackView.isLayoutMarginsRelativeArrangement = true
        testStackView.translatesAutoresizingMaskIntoConstraints = false
        testStackView.directionalLayoutMargins =  NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        NSLayoutConstraint.activate([
            testStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            testStackView.topAnchor.constraint(equalTo: testStackView.topAnchor, constant: 20)
        ])
        testStackView.addArrangedSubview(testLabel)
//        testStackView.addArrangedSubview(testLabelSecond)
    
        if isStackViewTapped {
        testStackView.addArrangedSubview(testLabelSecond)
            print("버튼이 탭되었습니다. True 상태")
        } else {
            print("버튼이 탭되었습니다. False 상태")
            testStackView.removeArrangedSubview(testLabel)
            testStackView.removeArrangedSubview(testLabelSecond)
            testStackView.addArrangedSubview(testLabel)
        }
    }
    
    private func addButtonToStackView() {
        let weekDays = [["월",false], ["화",false], ["수",false], ["목",false], ["금",false], ["토",false], ["일",false]]

        for weekDay in weekDays {
            let testButton: UIButton = {
                let button = UIButton()
                button.setTitle((weekDay[0] as? String), for: .normal)
                button.setTitle(weekDay[1] as? String, for: .highlighted)
                button.tintColor = .white
                button.backgroundColor = .systemBlue
                button.layer.cornerRadius = 10
                button.addTarget(self, action: #selector(weekDayButtonAction(_:)), for: .touchUpInside)
                return button
            }()
            if isStarted == false {
                stackView.addArrangedSubview(testButton)
            }
        }
        isStarted = true
    }
    
    @objc private func weekDayButtonAction(_ sender: UIButton!) {
        print("버튼입니다.")
    }
    
    @objc func testStackViewTapped(_ sender: UIStackView!) {
        isStackViewTapped.toggle()
        loadView()
        viewDidLoad()
    }
}

