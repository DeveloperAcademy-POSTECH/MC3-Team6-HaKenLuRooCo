//
//  MainViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim, 김연호, 코지 on 2022/07/18.

import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties
    private var genericTopics = [["요즘 핫한 과일은 뭘까요?", "최근 먹은 과일은 뭘까요?", "몸에 좋은 과일은 뭘까요?", "과일"], ["1", "2", "3", "숫자"], ["ㅁ", "ㄴ", "ㄷ", "한글"]]
    private var seriousTopics = [["요즘 가정 빚은 있나요?", "부부 금술은 좋나요?", "아들내미가 맘에 안드시나요?", "빚"], ["a", "c", "v", "심각한 알파벳"], ["칼", "총", "담배", "무서운 단어"]]
    private var topics: [String] = []
    var blueStampBox: [UIImageView] = []
    private var genericTopicIndex: Int = 0
    private var seriousTopicIndex: Int = 0
    enum PhoneNum: String {
        case momNum = "tel://01074080031"
        case dadNum = "tel://01046021620"
    }
    private func makeBox() {
        for _ in 0..<6 {
            let sqaureImage: UIImageView = {
                let image = UIImage(systemName: "checkmark.square.fill")
                let imageView = UIImageView(image: image)
                return imageView
            }()
            blueStampBox.append(sqaureImage)
        }
    }
    lazy var dadStampBox: UIStackView = {
        let stackView: UIStackView = {
            var stackView = UIStackView()
            for idx in 0...2 {
                stackView.addArrangedSubview(blueStampBox[idx])
            }
            return stackView
        }()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    lazy var momStampBox: UIStackView = {
        let stackView: UIStackView = {
            var stackView = UIStackView()
            for idx in 3...5 {
                stackView.addArrangedSubview(blueStampBox[idx])
            }
            return stackView
        }()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let momLabel: UILabel = {
        // 클래스를 이용하여 매개변수를 전달하는 방식으로 문자를 출력할 수 있는 방법 존재
        let label = UILabel()
        label.text = "엄마"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let dadLabel: UILabel = {
        let label = UILabel()
        label.text = "아빠"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private lazy var topRectangleDivider: UIView = {
        let rectangle = UIView()
        rectangle.backgroundColor = .systemGray3
        return rectangle
    }()
    private lazy var rightButton: UIBarButtonItem = {
        let buttonImage = UIImage(systemName: "person.circle")!
        let button = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(buttonPressed))
        return button
    }()

    private let topicTitleLabel: UILabel = {
        let topicTitle = UILabel()
        topicTitle.text = "오늘의 토픽"
        topicTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        return topicTitle
    }()

    private let topicLabel: UILabel = {
        let topicText = UILabel()
        topicText.font = .systemFont(ofSize: 20, weight: .semibold)
        return topicText
    }()
    private lazy var checkBackGroundRectangle: UIView = {
        let rectangle = UIView()
        rectangle.layer.cornerRadius = 15
        rectangle.backgroundColor = .systemGray5
        rectangle.addSubview(topRectangleDivider)
        topRectangleDivider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topRectangleDivider.topAnchor.constraint(equalTo: rectangle.topAnchor),
            topRectangleDivider.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 179),
            topRectangleDivider.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor, constant: -179),
            topRectangleDivider.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor)
        ])
        rectangle.addSubview(dadLabel)
        dadLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dadLabel.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 70),
            dadLabel.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 35)
        ])
        rectangle.addSubview(momLabel)
        momLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            momLabel.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor, constant: -70),
            momLabel.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 35)
        ])
        rectangle.addSubview(dadStampBox)
        dadStampBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dadStampBox.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 20),
            dadStampBox.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 80),
            dadStampBox.trailingAnchor.constraint(equalTo: dadStampBox.leadingAnchor, constant: 140),
            dadStampBox.bottomAnchor.constraint(equalTo: dadStampBox.topAnchor, constant: 40)
        ])
        rectangle.addSubview(momStampBox)
        momStampBox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            momStampBox.leadingAnchor.constraint(equalTo: momStampBox.trailingAnchor, constant: -140),
            momStampBox.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 80),
            momStampBox.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor, constant: -20),
            momStampBox.bottomAnchor.constraint(equalTo: momStampBox.topAnchor, constant: 40)
        ])
        return rectangle
    }()
    private lazy var backGroundRectangle: UIView = {
        let rectangle = UIView()
        rectangle.layer.cornerRadius = 15
        rectangle.backgroundColor = .systemGray5

        rectangle.addSubview(topicTitleLabel)
        topicTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topicTitleLabel.leadingAnchor.constraint(equalTo: rectangle.leadingAnchor, constant: 16),
            topicTitleLabel.topAnchor.constraint(equalTo: rectangle.topAnchor, constant: 14)
        ])

        rectangle.addSubview(topicSegmentedControl)
        topicSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topicSegmentedControl.leadingAnchor.constraint(equalTo: topicTitleLabel.leadingAnchor),
            topicSegmentedControl.trailingAnchor.constraint(equalTo: rectangle.trailingAnchor, constant: -16),
            topicSegmentedControl.topAnchor.constraint(equalTo: topicTitleLabel.bottomAnchor, constant: 10)
        ])

        rectangle.addSubview(topicLabel)
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topicLabel.leadingAnchor.constraint(equalTo: topicTitleLabel.leadingAnchor),
            topicLabel.topAnchor.constraint(equalTo: topicSegmentedControl.bottomAnchor, constant: 10)
        ])

        rectangle.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshButton.heightAnchor.constraint(equalToConstant: 32),
            refreshButton.widthAnchor.constraint(equalToConstant: 32),
            refreshButton.trailingAnchor.constraint(equalTo: topicSegmentedControl.trailingAnchor),
            refreshButton.topAnchor.constraint(equalTo: topicLabel.topAnchor)
        ])

        rectangle.addSubview(topicTableView)
        topicTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topicTableView.heightAnchor.constraint(equalToConstant: 150),
            topicTableView.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
            topicTableView.trailingAnchor.constraint(equalTo: refreshButton.trailingAnchor),
            topicTableView.bottomAnchor.constraint(equalTo: rectangle.bottomAnchor, constant: -15)
        ])
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

    private lazy var refreshButton: UIButton = {
            let refreshButton = UIButton(type: UIButton.ButtonType.system)
            refreshButton.setImage(UIImage(systemName: "goforward"), for: UIControl.State.normal)
            refreshButton.backgroundColor = .black
            refreshButton.tintColor = .white
            refreshButton.layer.cornerRadius = 10
            refreshButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            return refreshButton
        }()

    private let topicTableView: UITableView = {
        let topicTableView = UITableView()
        topicTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        topicTableView.reloadData()
        return topicTableView
    }()

    private lazy var callAlert: UIAlertController = {
        let callAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let momCall = UIAlertAction(title: "엄마한테 전화하기", style: .default) { _ in
            self.goCallApp(url: PhoneNum.momNum.rawValue)
        }
        let fatherNumber = UIAlertAction(title: "아빠한테 전화하기", style: .default) { _ in
            self.goCallApp(url: PhoneNum.dadNum.rawValue)
        }
        let cancel = UIAlertAction(title: "취소하기", style: .cancel)
        callAlert.addAction(momCall)
        callAlert.addAction(fatherNumber)
        callAlert.addAction(cancel)

        return callAlert
    }()

    private lazy var callButton: UIButton = {
        let callButton = UIButton(type: UIButton.ButtonType.system)
        callButton.setImage(UIImage(systemName: "phone.fill"), for: UIControl.State.normal)
        callButton.backgroundColor = .systemBlue
        callButton.tintColor = .white
        callButton.layer.cornerRadius = 9
        callButton.addTarget(self, action: #selector(callbuttonAction(_:)), for: .touchUpInside)
        return callButton
    }()

    // MARK: - LifeCycle

    override func loadView() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        genericTopicIndex = Int(formatter.string(from: Date()))! % genericTopics.count
        seriousTopicIndex = Int(formatter.string(from: Date()))! % seriousTopics.count
        topics = genericTopics[genericTopicIndex]
        topicLabel.text = topics.last
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTitle()
        view.backgroundColor = .systemGray5
        navigationItem.rightBarButtonItem = self.rightButton
        topicTableView.delegate = self
        topicTableView.dataSource = self
        topicTableView.allowsSelection = false
        makeBox()
        render()
    }
    // 네비게이션 타이틀을 다루기 위해 정의된 메소드
    func initTitle() {
        let label = UILabel()
        label.textColor = .black
        label.text = "전화 안 한지 7일"
        label.font = .boldSystemFont(ofSize: 25)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
    }

    @objc private func buttonAction(_: UIButton!) {
            switch topicSegmentedControl.selectedSegmentIndex {
            case 0:
                let previousIndex = genericTopicIndex
                repeat {
                    genericTopicIndex = Int.random(in: 0 ..< genericTopics.count)
                } while previousIndex == genericTopicIndex
                topics = genericTopics[genericTopicIndex]
                topicLabel.text = topics.last
            case 1:
                let previousIndex = seriousTopicIndex
                repeat {
                    seriousTopicIndex = Int.random(in: 0 ..< seriousTopics.count)
                } while previousIndex == seriousTopicIndex
                topics = seriousTopics[seriousTopicIndex]
                topicLabel.text = topics.last
            default:
                ()
            }
            topicTableView.reloadData()
        }

    @objc private func buttonPressed(_ sender: Any) {
        let viewController = SettingViewController()
        self.present(viewController, animated: true)
    }

    @objc private func callbuttonAction(_: UIButton!) {
        present(callAlert, animated: true, completion: nil)
    }

    @objc private func segmentedValueChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            topics = genericTopics[genericTopicIndex]
            topicLabel.text = topics.last
            topicLabel.font = .systemFont(ofSize: 20, weight: .semibold)

        default:
            topics = seriousTopics[seriousTopicIndex]
            topicLabel.text = topics.last
            topicLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        }

        topicTableView.reloadData()
    }

    // MARK: - Configures

    private func render() {
        view.backgroundColor = .systemBackground

        view.addSubview(checkBackGroundRectangle)
        checkBackGroundRectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBackGroundRectangle.heightAnchor.constraint(equalToConstant: 150),
            checkBackGroundRectangle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            checkBackGroundRectangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            checkBackGroundRectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        view.addSubview(backGroundRectangle)
        backGroundRectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backGroundRectangle.heightAnchor.constraint(equalToConstant: 300),
            backGroundRectangle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -170),
            backGroundRectangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backGroundRectangle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])

        view.addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callButton.leftAnchor.constraint(equalTo: backGroundRectangle.leftAnchor),
            callButton.rightAnchor.constraint(equalTo: backGroundRectangle.rightAnchor),
            callButton.heightAnchor.constraint(equalToConstant: 60),
            callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
    }

    private func attribute() {
        topicTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    private func goCallApp(url: String) {
        if let openApp = URL(string: url), UIApplication.shared.canOpenURL(openApp) {
            // 버전별 처리
            if #available(iOS 15.0, *) {
                UIApplication.shared.open(openApp, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(openApp)
            }
        }

        // 스키마명을 사용해 외부앱 실행이 불가능한 경우
        else {
            print("[goDeviceApp : 디바이스 외부 앱 열기 실패]")
            print("링크 주소 : \(url)")
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return topics.count - 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = topics[indexPath.row]
        return cell
    }
}
