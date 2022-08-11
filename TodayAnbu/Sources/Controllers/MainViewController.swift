//
//  MainViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim, 김연호, 코지 on 2022/07/18.

import Combine
import UIKit

class MainViewController: UIViewController {
    let settingView = SettingViewController()
    // MARK: - Properties
    private var genericTopics = generalTopicData
    private var seriousTopics = seriousTopicData
    var observer: NSObjectProtocol?
    var sceneObserver: NSObjectProtocol?

    private func topTitleDays(notCalledDate: Int) -> UILabel {
        let label = UILabel()
        label.text = "\(notCalledDate)일"
        label.textColor = .mainTitleOrange
        label.font = .boldSystemFont(ofSize: 27)
        return label
    }

    private lazy var topTitleDays = topTitleDays(notCalledDate: self.notCalledDate)
    private var topics: [String] = []
    private var genericTopicIndex: Int = 0
    private var seriousTopicIndex: Int = 0
    private var isCalling = false
    private var notCalledDate: Int = 0 {
        didSet(oldVal) {
            topTitleDays = topTitleDays(notCalledDate: notCalledDate)
            configureUI()
            configureAddSubView()
            configureTranslate()
            configureRender()
        }
    }
    var isMomCall = false
    var isDadCall = false
    var momPhoneNumber: String = "" {
        didSet {
            configureAll()
        }
    }
    var dadPhoneNumber: String = "" {
        didSet {
            configureAll()
        }
    }

    lazy var momCheckCount: Int = 0 {
        didSet {
            switch momCheckCount {
            case 1:
                momGauge1 = momGauge(momCheckCount: 1, gaugeColor: .momGaugeLight)
            case 2:
                momGauge2 = momGauge(momCheckCount: 2, gaugeColor: .momGaugeLight)
            case 3:
                momGauge3 = momGauge(momCheckCount: 3, gaugeColor: .momGaugeLight)
            default:
                print("")
            }
            configureAll()
        }
    }

    lazy var dadCheckCount: Int = 0 {
        didSet {
            switch dadCheckCount {
            case 1:
                dadGauge1 = dadGauge(dadCheckCount: 1, gaugeColor: .systemPurple)
            case 2:
                dadGauge2 = dadGauge(dadCheckCount: 2, gaugeColor: .systemPurple)
            case 3:
                dadGauge3 = dadGauge(dadCheckCount: 3, gaugeColor: .systemPurple)
            default:
                print("")
            }
            configureAll()
        }
    }

    private let topArea: UIView = {
        let area = UIView()
        area.layer.cornerRadius = 15
        area.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        area.backgroundColor = .mainIndigo
        return area
    }()

    lazy private var topTitle: UIStackView = {
        let titleHStack = UIStackView()
        titleHStack.axis = .horizontal
        titleHStack.spacing = 10
        titleHStack.addArrangedSubview(topTitleFirstLabel)
        titleHStack.addArrangedSubview(topTitleDays)
        titleHStack.addArrangedSubview(topTitleSecondLabel)
        return titleHStack
    }()

    private let topTitleFirstLabel: UILabel = {
        let label = UILabel()
        let dayLabel = UILabel()
        label.textColor = .mainTitleFontColor
        label.text = "전화한지"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()

    private let topTitleSecondLabel: UILabel = {
        let label = UILabel()
        let dayLabel = UILabel()
        label.textColor = .mainTitleFontColor
        label.text = "되었어요"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()

    private let weeklyAnbuLabel: UILabel = {
        let label = UILabel()
        label.text = "이번주 안부"
        label.font = .systemFont(ofSize: 26, weight: .heavy)
        label.textColor = .white
        return label
    }()

    private lazy var settingButton: UIButton = {
        let setButton = UIButton()
        setButton.setImage(UIImage(systemName: "gearshape.fill"), for: UIControl.State.normal)
        setButton.backgroundColor = .mainIndigo
        setButton.tintColor = .white
        setButton.addTarget(self, action: #selector(setButtonAction(_:)), for: .touchUpInside)
        return setButton
    }()

    private let momLabel: UILabel = {
        let label = UILabel()
        label.text = "어머니"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()

    private let dadLabel: UILabel = {
        let label = UILabel()
        label.text = "아버지"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()

    private func momGauge(momCheckCount: Int, gaugeColor: UIColor!) -> UIView {
        let capsule = UIView()
        capsule.layer.cornerRadius = 10
        capsule.backgroundColor = gaugeColor
        return capsule
    }
    private lazy var momGauge1 = momGauge(momCheckCount: 1, gaugeColor: .momGaugeDeep)
    private lazy var momGauge2 = momGauge(momCheckCount: 2, gaugeColor: .momGaugeDeep)
    private lazy var momGauge3 = momGauge(momCheckCount: 3, gaugeColor: .momGaugeDeep)

    private func dadGauge(dadCheckCount: Int, gaugeColor: UIColor!) -> UIView {
        let capsule = UIView()
        capsule.layer.cornerRadius = 10
        capsule.backgroundColor = gaugeColor
        return capsule
    }
    private lazy var dadGauge1 = dadGauge(dadCheckCount: 1, gaugeColor: .dadGaugeDeep)
    private lazy var dadGauge2 = dadGauge(dadCheckCount: 2, gaugeColor: .dadGaugeDeep)
    private lazy var dadGauge3 = dadGauge(dadCheckCount: 3, gaugeColor: .dadGaugeDeep)

    private lazy var topicSegmentedControl: UISegmentedControl = {
        let segmentItems = ["가벼운 토픽", "진지한 토픽"]
        let topicSegmentedControl = UISegmentedControl(items: segmentItems)

        topicSegmentedControl.selectedSegmentIndex = 0
        topicSegmentedControl.tintColor = .black
        topicSegmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return topicSegmentedControl
    }()

    private let topicLabel: UILabel = {
        let topicText = UILabel()
        topicText.font = .systemFont(ofSize: 24, weight: .semibold)
        return topicText
    }()

    private lazy var refreshButton: UIButton = {
            let refreshButton = UIButton(type: UIButton.ButtonType.system)
            refreshButton.setImage(UIImage(systemName: "goforward"), for: UIControl.State.normal)
            refreshButton.backgroundColor = .white
            refreshButton.tintColor = .mainIndigo
            refreshButton.layer.cornerRadius = 5
            refreshButton.frame.size = CGSize(width: 50, height: 30)
            refreshButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            return refreshButton
        }()

    private let topicTableView: UITableView = {
        let topicTableView = UITableView()
        topicTableView.estimatedRowHeight = UITableView.automaticDimension
        topicTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        topicTableView.reloadData()
        topicTableView.layer.cornerRadius = 10
        topicTableView.isScrollEnabled = false
        return topicTableView
    }()

    private lazy var callAlert: UIAlertController = {
        let callAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let momCall = UIAlertAction(title: "어머니한테 전화하기", style: .default) { _ in
            CallManager.shared.data.isMomCall.toggle()
            self.isCalling.toggle()
            self.goCallApp(url: "tel://" + (UserDefaults.standard.string(forKey: "momPhoneNumber") ?? ""))
            print(self.notCalledDate)
        }

        let dadCall = UIAlertAction(title: "아버지한테 전화하기", style: .default) { _ in
            CallManager.shared.data.isDadCall.toggle()
            self.isCalling.toggle()
            self.goCallApp(url: "tel://" + (UserDefaults.standard.string(forKey: "dadPhoneNumber") ?? ""))
        }
        let cancel = UIAlertAction(title: "취소하기", style: .cancel)

        if let momPhoneNumber = UserDefaults.standard.string(forKey: "momPhoneNumber") {
            if !momPhoneNumber.isEmpty {
                callAlert.addAction(momCall)
            }
        }
        if let dadPhoneNumber = UserDefaults.standard.string(forKey: "dadPhoneNumber") {
            if !dadPhoneNumber.isEmpty {
                callAlert.addAction(dadCall)
            }
        }
        callAlert.addAction(cancel)
        return callAlert
    }()

    private lazy var callButton: UIButton = {
        let callButton = UIButton(type: UIButton.ButtonType.system)
        callButton.setImage(UIImage(systemName: "phone.fill"), for: UIControl.State.normal)
        callButton.setTitle(" 안부묻기", for: .normal)
        callButton.titleLabel?.font = .systemFont(ofSize: 24, weight: UIFont.Weight.semibold)
        callButton.backgroundColor = .mainIndigo
        callButton.tintColor = .white
        callButton.layer.cornerRadius = 10
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

    private var cancelBag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAll()
        configureNotCalledDate()

        CallManager.shared.$data
            .sink { [weak self] data in
                self?.momCheckCount = data.momCheckCount
                self?.dadCheckCount = data.dadCheckCount
                if let notCalledDate = data.notCallDate {
                    self?.notCalledDate = notCalledDate
                }
            }.store(in: &cancelBag)

        self.navigationItem.setHidesBackButton(true, animated: true)
        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [unowned self] _ in
            if self.isCalling {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CallCheckViewController") as? CallCheckViewController
            self.present(nextViewController!, animated: true) {
                self.isCalling.toggle()
                }
            }
        }
        self.navigationController?.setToolbarHidden(true, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }

    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    private func configureAll() {
        configureUI()
        configureAddSubView()
        configureTranslate()
        configureRender()
    }
    // MARK: - Configures
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    private func configureAddSubView() {
        view.addSubview(topArea)
        view.addSubview(topTitle)
        view.addSubview(weeklyAnbuLabel)
        view.addSubview(momLabel)
        view.addSubview(dadLabel)
        view.addSubview(topicSegmentedControl)
        view.addSubview(topicLabel)
        view.addSubview(refreshButton)
        view.addSubview(topicTableView)
        view.addSubview(callButton)
        view.addSubview(momGauge1)
        view.addSubview(momGauge2)
        view.addSubview(momGauge3)
        view.addSubview(dadGauge1)
        view.addSubview(dadGauge2)
        view.addSubview(dadGauge3)
        view.addSubview(settingButton)
    }

    private func configureTranslate() {
        topArea.translatesAutoresizingMaskIntoConstraints = false
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        topTitleDays.translatesAutoresizingMaskIntoConstraints = false
        weeklyAnbuLabel.translatesAutoresizingMaskIntoConstraints = false
        topicSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        topicTableView.translatesAutoresizingMaskIntoConstraints = false
        callButton.translatesAutoresizingMaskIntoConstraints = false
        dadLabel.translatesAutoresizingMaskIntoConstraints = false
        momLabel.translatesAutoresizingMaskIntoConstraints = false
        momGauge1.translatesAutoresizingMaskIntoConstraints = false
        momGauge2.translatesAutoresizingMaskIntoConstraints = false
        momGauge3.translatesAutoresizingMaskIntoConstraints = false
        dadGauge1.translatesAutoresizingMaskIntoConstraints = false
        dadGauge2.translatesAutoresizingMaskIntoConstraints = false
        dadGauge3.translatesAutoresizingMaskIntoConstraints = false
        settingButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func configureRender() {
        topicTableView.delegate = self
        topicTableView.dataSource = self
        topicTableView.allowsSelection = false
        NSLayoutConstraint.activate([
            topArea.leftAnchor.constraint(equalTo: view.leftAnchor),
            topArea.rightAnchor.constraint(equalTo: view.rightAnchor),
            topArea.topAnchor.constraint(equalTo: view.topAnchor),
            topArea.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 260)
        ])
        NSLayoutConstraint.activate([
            topTitle.leadingAnchor.constraint(equalTo: topArea.leadingAnchor, constant: 20),
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            settingButton.centerYAnchor.constraint(equalTo: topTitle.centerYAnchor),
            settingButton.widthAnchor.constraint(equalToConstant: 40),
            settingButton.trailingAnchor.constraint(equalTo: topArea.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            weeklyAnbuLabel.leadingAnchor.constraint(equalTo: topArea.leadingAnchor, constant: 20),
            weeklyAnbuLabel.topAnchor.constraint(equalTo: topTitle.topAnchor, constant: 50)
        ])
        NSLayoutConstraint.activate([
            momLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            momLabel.topAnchor.constraint(equalTo: weeklyAnbuLabel.bottomAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            dadLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dadLabel.topAnchor.constraint(equalTo: momLabel.bottomAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            momGauge1.leadingAnchor.constraint(equalTo: momLabel.trailingAnchor, constant: 20),
            momGauge1.topAnchor.constraint(equalTo: momLabel.topAnchor, constant: -3),
            momGauge1.bottomAnchor.constraint(equalTo: momLabel.bottomAnchor, constant: 3),
            momGauge1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -217)
        ])
        NSLayoutConstraint.activate([
            momGauge2.leadingAnchor.constraint(equalTo: momGauge1.trailingAnchor, constant: 5),
            momGauge2.topAnchor.constraint(equalTo: momGauge1.topAnchor),
            momGauge2.bottomAnchor.constraint(equalTo: momGauge1.bottomAnchor),
            momGauge2.trailingAnchor.constraint(equalTo: momGauge2.leadingAnchor, constant: 75)
        ])
        NSLayoutConstraint.activate([
            momGauge3.leadingAnchor.constraint(equalTo: momGauge2.trailingAnchor, constant: 5),
            momGauge3.topAnchor.constraint(equalTo: momGauge1.topAnchor),
            momGauge3.bottomAnchor.constraint(equalTo: momGauge1.bottomAnchor),
            momGauge3.trailingAnchor.constraint(equalTo: momGauge3.leadingAnchor, constant: 75)
        ])
        NSLayoutConstraint.activate([
            dadGauge1.leadingAnchor.constraint(equalTo: dadLabel.trailingAnchor, constant: 20),
            dadGauge1.topAnchor.constraint(equalTo: dadLabel.topAnchor, constant: -3),
            dadGauge1.bottomAnchor.constraint(equalTo: dadLabel.bottomAnchor, constant: 3),
            dadGauge1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -217)
        ])
        NSLayoutConstraint.activate([
            dadGauge2.leadingAnchor.constraint(equalTo: dadGauge1.trailingAnchor, constant: 5),
            dadGauge2.topAnchor.constraint(equalTo: dadGauge1.topAnchor),
            dadGauge2.bottomAnchor.constraint(equalTo: dadGauge1.bottomAnchor),
            dadGauge2.trailingAnchor.constraint(equalTo: dadGauge2.leadingAnchor, constant: 75)
        ])
        NSLayoutConstraint.activate([
            dadGauge3.leadingAnchor.constraint(equalTo: dadGauge2.trailingAnchor, constant: 5),
            dadGauge3.topAnchor.constraint(equalTo: dadGauge1.topAnchor),
            dadGauge3.bottomAnchor.constraint(equalTo: dadGauge1.bottomAnchor),
            dadGauge3.trailingAnchor.constraint(equalTo: dadGauge3.leadingAnchor, constant: 75)
        ])
        NSLayoutConstraint.activate([
            topicSegmentedControl.topAnchor.constraint(equalTo: topArea.bottomAnchor, constant: 30),
            topicSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            topicSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])

        NSLayoutConstraint.activate([
            topicLabel.leadingAnchor.constraint(equalTo: topicSegmentedControl.leadingAnchor, constant: 15),
            topicLabel.topAnchor.constraint(equalTo: topicSegmentedControl.bottomAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            refreshButton.heightAnchor.constraint(equalToConstant: 32),
            refreshButton.widthAnchor.constraint(equalToConstant: 32),
            refreshButton.trailingAnchor.constraint(equalTo: topicSegmentedControl.trailingAnchor),
            refreshButton.topAnchor.constraint(equalTo: topicSegmentedControl.bottomAnchor, constant: 17)
        ])

        NSLayoutConstraint.activate([
            topicTableView.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 20),
            topicTableView.heightAnchor.constraint(equalToConstant: 150),
            topicTableView.leadingAnchor.constraint(equalTo: topicSegmentedControl.leadingAnchor),
            topicTableView.trailingAnchor.constraint(equalTo: refreshButton.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            callButton.heightAnchor.constraint(equalToConstant: 55),
            callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func configureNotCalledDate() {
        let currentTime =  Date.currentNumericLocalizedDateTime
        guard let callTime = UserDefaults.standard.string(forKey: "lastCallTime") else {
            self.notCalledDate = 0
            UserDefaults.standard.set(Date.currentNumericLocalizedDateTime, forKey: "lastCallTime")
            return
        }
        notCalledDate = Date.dayDifference(callTime, currentTime) ?? 0
    }
}

    // MARK: - extension
    extension MainViewController: UITableViewDataSource {

        func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
            return topics.count - 1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemGray6
            cell.textLabel?.text = topics[indexPath.row]
            cell.textLabel?.numberOfLines = 2
            return cell
        }
    }
    extension MainViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
    }

// MARK: - func
extension MainViewController {

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

    private func attribute() {
        topicTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @objc private func buttonAction(_: UIButton!) {
        print("refreshbutton")
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

    @objc private func callbuttonAction(_: UIButton!) {
        present(callAlert, animated: true, completion: nil)
    }

    @objc private func setButtonAction(_: UIButton!) {
        let settingViewControllerNavigation = UINavigationController(rootViewController: SettingViewController())
        present(settingViewControllerNavigation, animated: true, completion: nil)
    }

    @objc private func segmentedValueChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            topics = genericTopics[genericTopicIndex]
            topicLabel.text = topics.last
            topicLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        default:
            topics = seriousTopics[seriousTopicIndex]
            topicLabel.text = topics.last
            topicLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        }
        topicTableView.reloadData()
    }
}

class CheckButtonTapGesture: UITapGestureRecognizer {
    var indexOfButton = Int()
}
