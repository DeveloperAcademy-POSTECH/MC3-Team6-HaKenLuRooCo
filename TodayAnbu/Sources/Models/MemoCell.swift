//
//  MemoCell.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/27.
//

import UIKit

class MemoCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // descriptionLabel.sizeToFit()
        // descriptionLabel.textAlignment = .natural
        // descriptionLabel.numberOfLines = 0;
        // descriptionLabel.adjustsFontSizeToFitWidth = true
    }

    func configure(_ memodata: MemoData) {
        descriptionLabel.text = memodata.description
        dayLabel.text = String(memodata.day)
    }
}
