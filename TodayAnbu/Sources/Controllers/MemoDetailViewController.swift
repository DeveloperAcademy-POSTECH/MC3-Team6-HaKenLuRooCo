//
//  MemoDetailViewController.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/31.
//

import UIKit

class MemoDetailViewController: UIViewController {
    private let topArea: UIView = {
        let area = UIView()
        area.layer.cornerRadius = 15
        area.backgroundColor = .mainIndigo
        return area
    }()
    private let topTitle: UILabel = {
        let label = UILabel()
        label.text = "어떤 대화였을까요?"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()
    private let memoDate: UILabel = {
        let label = UILabel()
        label.text = "7월 11일"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    private let memoArea: UIView = {
        let area = UIView()
        area.layer.cornerRadius = 15
        area.backgroundColor = .systemGray5
        return area
    }()
    private let memoLabel: UILabel = {
        let label = UILabel()
        var dict: [String: String] = [:]
        dict = UserDefaults.standard.value(forKey: "momMemo") as? [String: String] ?? [:]
        let memoDates = [String](dict.keys)
        let memoDescription = [String](dict.values)
        label.text = memoDescription[0]
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
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
            topArea.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            topArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topArea.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            topTitle.leadingAnchor.constraint(equalTo: topArea.leadingAnchor, constant: 80),
            topTitle.topAnchor.constraint(equalTo: topArea.safeAreaLayoutGuide.topAnchor, constant: -15)
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
