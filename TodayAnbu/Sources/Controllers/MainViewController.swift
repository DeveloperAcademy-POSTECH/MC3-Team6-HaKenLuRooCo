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
    private var genericTopics = [["최근에 가고 싶은 여행지가 있나요?", "가장 좋았던 여행지가 어디인가요?", "가장 최근에 다녀온 여행지가 어디인가요?", "여행"], ["최근에 본 영화가 있나요?", "가장 좋아하는 영화가 무엇인가요?", "보고 싶은 영화가 있나요?", "영화"], ["최근에 읽은 책이 있나요?", "읽고 싶은 책이 있나요?", "가장 감명 깊게 읽은 책이 무엇인가요?", "책"], ["가장 좋아하는 음악 장르는 무엇인가요?", "최근 들어 자주 듣는 노래가 있으신가요?", "좋아하는 가수가 있으신가요?", "음악"], ["고양이가 좋으세요? 강아지가 좋으세요?", "반려동물을 키운다면 어떨 것 같나요?", "앵무새나 물고기처럼 기르고 싶은 특별한 반려동물이 있나요?", "반려동물"], ["어떤 술을 좋아하시나요?", "음료 중에 어떤게 가장 좋으세요?", "차는 어떤게 좋으세요?", "음료"], ["좋아하는 스포츠가 있으신가요?", "재밌게 보는 스포츠가 있나요?", "운동 좋아하세요?", "스포츠"], ["취미가 무엇인가요?", "새로 배워보고 싶은 취미가 있나요?", "과거에 즐겨했었던 취미가 있나요?", "취미"], ["최근에 복날에 닭은 드셨나요?", "생일 때 뭐 받고 싶으신 게 있나요?", "결혼기념일에 뭐 하실지 생각해보셨어요?", "기념일"]]
    private var seriousTopics = [["최근에 뉴스에 나온 oo 사건 보셨어요?", "ㅇㅇ 정치인에 대해 어떻게 생각하세요?", "ㅇㅇ 정책에 대해 어떻게 생각하세요?", "사회 & 정치"], ["은퇴에 대한 걱정이 있으신가요?", "새로 하시는 일은 어떠세요?", "(이직/퇴사) 어떻게 하는게 좋을까요?", "진로"], ["주변에 괜찮은 사람 소개 좀 시켜줘요", "아는분 자녀 중에 결혼한 사람들 있어요?", "결혼한 사람들이 결혼에 대해서 어떻게 생각한대요?", "만남"], ["환율 어떨거 같아요?", "주식 어떨거 같아요?", "부동산 어떨거 같아요?", "경제"], ["사이가 안좋은 가족이 있다면 현재 어떠신지?", "지금 어머님/아버님에게 서운한 부분이 있으신가요?", "도움이 필요한데 말씀 못 하고 계시진 않나요?", "가족사"], ["금전적으로 도와드려야 할까요?", "(형제/자매) 요즘 괜찮대요?", "현재 우리 가정에 빚이 얼마나 있나요?", "가족의 경제현황"], ["지금 솔직하게 어떤게 제일 불편하세요?", "도움이 필요한데 말씀 못 하고 계시진 않나요?", "배우자에게 건강상 이상한 점을 보신적이 있나요?", "건강"]]
    var observer: NSObjectProtocol?
    var sceneObserver: NSObjectProtocol?

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
            configureUI()
            configureAddSubView()
            configureTranslate()
            configureRender()
        }
    }
    var dadPhoneNumber: String = "" {
        didSet {
            configureUI()
            configureAddSubView()
            configureTranslate()
            configureRender()
        }
    }

    lazy var momCheckCount: Int = 0 {
        didSet {
            switch momCheckCount {
            case 1:
                momGauge1 = momGauge(momCheckCount: 1, gaugeColor: .momGaugeLight)
                configureUI()
                configureAddSubView()
                configureTranslate()
                configureRender()
            case 2:
                momGauge2 = momGauge(momCheckCount: 2, gaugeColor: .momGaugeLight)
                configureUI()
                configureAddSubView()
                configureTranslate()
                configureRender()
            case 3:
                momGauge3 = momGauge(momCheckCount: 3, gaugeColor: .momGaugeLight)
                configureUI()
                configureAddSubView()
                configureTranslate()
                configureRender()
            default:
                print("")
            }
        }
    }
    lazy var dadCheckCount: Int = 0 {
        didSet {
            switch dadCheckCount {
            case 1:
                dadGauge1 = dadGauge(dadCheckCount: 1, gaugeColor: .dadGaugeLight)
                configureUI()
                configureAddSubView()
                configureTranslate()
                configureRender()
            case 2:
                dadGauge2 = dadGauge(dadCheckCount: 2, gaugeColor: .dadGaugeLight)
                configureUI()
                configureAddSubView()
                configureTranslate()
                configureRender()
            case 3:
                dadGauge3 = dadGauge(dadCheckCount: 3, gaugeColor: .dadGaugeLight)
                configureUI()
                configureAddSubView()
                configureTranslate()
                configureRender()
            default:
                print("")
            }
        }
    }

    private let topArea: UIView = {
        let area = UIView()
        area.layer.cornerRadius = 20
        area.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        area.backgroundColor = .mainIndigo
        return area
    }()
    private let topTitle: UILabel = {
        let label = UILabel()
        let dayLabel = UILabel()
        label.textColor = .mainTitleFontColor
        label.text = "전화한지         되었어요"
        label.font = .boldSystemFont(ofSize: 25)

        return label
    }()
    private func topTitleDays(notCalledDate: Int) -> UILabel {
        let label = UILabel()
        label.text = "\(notCalledDate)일"
        label.textColor = .mainTitleOrange
        label.font = .boldSystemFont(ofSize: 27)
        return label
    }
    private lazy var topTitleDays = topTitleDays(notCalledDate: self.notCalledDate)

    private let weeklyAnbuLabel: UILabel = {
        let label = UILabel()
        label.text = "이번주 안부"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
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

    private let topicLabel: UILabel = {
        let topicText = UILabel()
        topicText.font = .systemFont(ofSize: 20, weight: .semibold)
        return topicText
    }()
    private lazy var topicSegmentedControl: UISegmentedControl = {
        let segmentItems = ["가벼운 토픽", "진지한 토픽"]
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
            refreshButton.backgroundColor = .mainIndigo
            refreshButton.tintColor = .white
            refreshButton.layer.cornerRadius = 15
            refreshButton.frame.size = CGSize(width: 30, height: 30)
            refreshButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            return refreshButton
        }()

    private let topicTableView: UITableView = {
        let topicTableView = UITableView()
        topicTableView.estimatedRowHeight = UITableView.automaticDimension
        topicTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        topicTableView.reloadData()
        topicTableView.layer.cornerRadius = 10
        topicTableView.backgroundColor = .black
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
        configureUI()
        configureAddSubView()
        configureTranslate()
        configureRender()
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

//        let currentTime =  Date.currentNumericLocalizedDateTime
//        guard let callTime = UserDefaults.standard.string(forKey: "lastCallTime") else {
//            self.notCalledDate = 0
//            UserDefaults.standard.set(Date.currentNumericLocalizedDateTime, forKey: "lastCallTime")
//            return
//        }
//        self.notCalledDate = Date.dayDifference(callTime, currentTime) ?? 0
    }

    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    // MARK: - Configures
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    private func configureAddSubView() {
        view.addSubview(topArea)
        view.addSubview(topTitle)
        view.addSubview(topTitleDays)
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
            topTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            topTitleDays.leadingAnchor.constraint(equalTo: topArea.leadingAnchor, constant: 112),
            topTitleDays.bottomAnchor.constraint(equalTo: topTitle.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            settingButton.centerYAnchor.constraint(equalTo: topTitle.centerYAnchor),
            settingButton.widthAnchor.constraint(equalToConstant: 40),
            settingButton.trailingAnchor.constraint(equalTo: topArea.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            weeklyAnbuLabel.leadingAnchor.constraint(equalTo: topArea.leadingAnchor, constant: 20),
            weeklyAnbuLabel.topAnchor.constraint(equalTo: topTitle.topAnchor, constant: 60)
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
            topicSegmentedControl.topAnchor.constraint(equalTo: topArea.bottomAnchor, constant: 50),
            topicSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            topicSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])

        NSLayoutConstraint.activate([
            topicLabel.leadingAnchor.constraint(equalTo: topicSegmentedControl.leadingAnchor),
            topicLabel.topAnchor.constraint(equalTo: topicSegmentedControl.bottomAnchor, constant: 35)
        ])

        NSLayoutConstraint.activate([
            refreshButton.heightAnchor.constraint(equalToConstant: 32),
            refreshButton.widthAnchor.constraint(equalToConstant: 32),
            refreshButton.trailingAnchor.constraint(equalTo: topicSegmentedControl.trailingAnchor),
            refreshButton.topAnchor.constraint(equalTo: topicLabel.topAnchor)
        ])

        NSLayoutConstraint.activate([
            topicTableView.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 30),
            topicTableView.heightAnchor.constraint(equalToConstant: 150),
            topicTableView.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
            topicTableView.trailingAnchor.constraint(equalTo: refreshButton.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            callButton.heightAnchor.constraint(equalToConstant: 55),
            callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }

    private func configureNotCalledDate() {
        let currentTime =  Date.currentNumericLocalizedDateTime
        guard let callTime = UserDefaults.standard.string(forKey: "lastCallTime") else {
            self.notCalledDate = 0
            UserDefaults.standard.set(Date.currentNumericLocalizedDateTime, forKey: "lastCallTime")
            return
        }
        //callTime을 원하는 값으로 설정해주면 영상 찍을 때 가라 가능합니다.
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
            cell.backgroundColor = .systemGray5
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
        print(self.notCalledDate)
    }

    @objc private func setButtonAction(_: UIButton!) {
        self.present(settingView, animated: true) {
            self.settingView.configureViewComponent()
        }
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
}

class CheckButtonTapGesture: UITapGestureRecognizer {
    var indexOfButton = Int()
}
