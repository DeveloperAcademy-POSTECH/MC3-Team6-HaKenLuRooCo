//
//  MemoDetailViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/31.
//
import UIKit

class MemoDetailViewController: UIViewController {

    var memoData: MemoData
    init(memoData: MemoData) {
        self.memoData = memoData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let topArea: UIView = {
        let area = UIView()
        area.backgroundColor = .mainIndigo
        return area
    }()
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = "대화 내용"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()
    private lazy var memoDate: UILabel = {
        let label = UILabel()
        label.text = memoData.date
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    private let memoArea: UIView = {
        let area = UIView()
        area.layer.cornerRadius = 15
        area.backgroundColor = .memoColor
        return area
    }()
    private lazy var memoLabel: UILabel = {
        let label = UILabel()
        label.text = memoData.description
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 4
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponent()
        UserDefaults.standard.set("요즘 멜론을 드시기 시작하셨다고 한다. 멜론에는 유바리, 갈리아, 감로, 칸탈로프, 머스크 등 정말 많은 종류가 존재한다. 그래도 역시 네트 머스크형이 제일 맛있는거 같다고 하셨다. 멜론에는 칼륨이 매우 풍부하고 이뇨 효과가 있어 몸의 부기를 뺴고 신장 기능에 도움을 주는 효과가 있다.", forKey: "KenExample")
    }
    func configureViewComponent() {
        view.backgroundColor = .white
        view.addSubview(topArea)
        view.addSubview(topTitle)
        view.addSubview(memoDate)
        view.addSubview(memoArea)
        view.addSubview(memoLabel)
        topArea.translatesAutoresizingMaskIntoConstraints = false
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        memoDate.translatesAutoresizingMaskIntoConstraints = false
        memoArea.translatesAutoresizingMaskIntoConstraints = false
        memoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topArea.topAnchor.constraint(equalTo: view.topAnchor),
            topArea.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            topArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topArea.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            topTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topTitle.topAnchor.constraint(equalTo: topArea.safeAreaLayoutGuide.topAnchor, constant: -25)
        ])
        NSLayoutConstraint.activate([
            memoDate.topAnchor.constraint(equalTo: topArea.bottomAnchor, constant: 20),
            memoDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            memoArea.topAnchor.constraint(equalTo: memoDate.bottomAnchor, constant: 20),
            memoArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            memoArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            memoArea.bottomAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            memoLabel.topAnchor.constraint(equalTo: memoArea.topAnchor, constant: 20),
            memoLabel.leadingAnchor.constraint(equalTo: memoArea.leadingAnchor, constant: 20),
            memoLabel.trailingAnchor.constraint(equalTo: memoArea.trailingAnchor, constant: -20)
        ])
    }
}
