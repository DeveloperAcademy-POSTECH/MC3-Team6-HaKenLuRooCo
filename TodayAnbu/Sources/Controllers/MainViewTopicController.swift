//
//  MainViewTopicController.swift
//  TodayAnbu
//
//  Created by 김연호 on 2022/07/14.
//

import UIKit

class MainViewTopicController: UIViewController {
    private let topicTitleLabel: UILabel = {
        let topicTitle = UILabel()
        topicTitle.text = "오늘의 토픽"
        topicTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        return topicTitle
    }()

    private let topicLabel: UILabel = {
        let topicText = UILabel()
        topicText.text = "과일"
        topicText.font = .systemFont(ofSize: 20, weight: .semibold)
        return topicText
    }()

    private lazy var backGroundRectangle: UIView = {
        let rectangle = UIView()
        rectangle.layer.cornerRadius = 15
        rectangle.backgroundColor = .systemGray5

        rectangle.addSubview(topicTitleLabel)
        topicTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        topicTitleLabel.leftAnchor.constraint(equalTo: rectangle.leftAnchor, constant: 16).isActive = true
        topicTitleLabel.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 14).isActive = true

        rectangle.addSubview(topicSegmentedControl)
        topicSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        topicSegmentedControl.leftAnchor.constraint(equalTo: topicTitleLabel.leftAnchor).isActive = true
        topicSegmentedControl.rightAnchor.constraint(equalTo: rectangle.rightAnchor, constant: -16).isActive = true
        topicSegmentedControl.topAnchor.constraint(equalTo: topicTitleLabel.bottomAnchor, constant: 10).isActive = true
        rectangle.addSubview(topicLabel)
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        topicLabel.leftAnchor.constraint(equalTo: topicTitleLabel.leftAnchor).isActive = true
        topicLabel.topAnchor.constraint(equalTo: topicSegmentedControl.bottomAnchor, constant: 10).isActive = true

        rectangle.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.rightAnchor.constraint(equalTo: topicSegmentedControl.rightAnchor).isActive = true
        refreshButton.topAnchor.constraint(equalTo: topicLabel.topAnchor).isActive = true
        return rectangle
    }()

    private lazy var topicSegmentedControl: UISegmentedControl = {
        let segmentItems = ["가벼운", "진지한"]
        let topicSegmentedControl = UISegmentedControl(items: segmentItems)
        topicSegmentedControl.selectedSegmentIndex = 0
        topicSegmentedControl.backgroundColor = .systemGray3
        topicSegmentedControl.tintColor = .black
        topicSegmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return topicSegmentedControl
    }()

    @objc func segmentedValueChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            topicLabel.text = "과일"
            topicLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        default:
            topicLabel.text = "빚"
            topicLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        }
    }

    private lazy var refreshButton: UIButton = {
        let refreshButton = UIButton(type: UIButton.ButtonType.system)
        refreshButton.setImage(UIImage.init(systemName: "goforward"), for: UIControl.State.normal)
        refreshButton.backgroundColor = .black
        refreshButton.tintColor = .white
        refreshButton.layer.cornerRadius = 9
        refreshButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return refreshButton
    }()
    
    @objc func buttonAction(_ sender: UIButton!) {
        print("Button Work!")
    }

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }

    // MARK: Configures

    func render() {
        view.backgroundColor = .systemBackground
        view.addSubview(backGroundRectangle)
        backGroundRectangle.translatesAutoresizingMaskIntoConstraints = false
        backGroundRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backGroundRectangle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backGroundRectangle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        backGroundRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        backGroundRectangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
    }
}
