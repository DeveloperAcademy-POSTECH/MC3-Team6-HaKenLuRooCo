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
        label.textColor = .white
        return label
    }()
//    eprivate let memoArea = {
//
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponent()
    }
    func configureViewComponent() {
        view.addSubview(topArea)
        view.addSubview(topTitle)
        view.addSubview(memoDate)
        topArea.translatesAutoresizingMaskIntoConstraints = false
        topTitle.translatesAutoresizingMaskIntoConstraints = false
        memoDate.translatesAutoresizingMaskIntoConstraints = false
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
            memoDate.topAnchor.constraint(equalTo: topArea.bottomAnchor, constant: 10),
            memoDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
}
