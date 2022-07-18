//
//  SettingPersonalDataCell.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/17.
//

import UIKit

class SettingPersonalDataCell: UITableViewCell {
    // MARK: Properties
    let menuLable = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: Helpers
    func configure() {
        addSubview(menuLable)
        menuLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            menuLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 12)
        ])
    }

}

//인셋 그룹으로 바꾸는 방법

