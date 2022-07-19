//
//  SettingHeaderView.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/18.
//

import UIKit

class SettingHeaderView: UIView {
    // MARK: Properties
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    lazy var userLabel: UILabel={
        let label = UILabel()
        label.text = "루루코"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Helpers
    func configure() {
        addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        addSubview(userLabel)
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
    }
}
