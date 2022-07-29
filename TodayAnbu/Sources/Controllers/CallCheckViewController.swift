//
//  CallCheckViewController.swift
//  TodayAnbu
//
//  Created by taekkim on 2022/07/28.
//

import UIKit

class CallCheckViewController: UIViewController {

    @IBOutlet weak var memoView: UITextView!
    @IBOutlet weak var callDoneButton: UIButton!
    @IBOutlet weak var callFailButton: UIButton!
    private let placeholder = "ex) 어머니에게 최근 먹은 과일에 대해 여쭤보았다. 어머니가 수박을 좋아하시는 걸 알게 되어서, 여름이 가기 전에 수박을 사드려야겠다."

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        configureButtons()
    }
}

// MARK: - Functions
extension CallCheckViewController {
    func configureTextView() {
        memoView.font = .systemFont(ofSize: 16.0, weight: .regular)
        memoView.text = placeholder
        memoView.textColor = .placeholderText
        memoView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        memoView.layer.shadowColor = UIColor.systemGray.cgColor
        memoView.layer.shadowOffset = CGSize(width: 0, height: 4)
        memoView.layer.shadowRadius = 5
        memoView.layer.shadowOpacity = 1
        memoView.layer.masksToBounds = false
        memoView.layer.cornerRadius = 20
        memoView.delegate = self
    }
    func configureButtons() {
        callDoneButton.addTarget(self, action: #selector(onTapDoneButton), for: .touchUpInside)
        callFailButton.addTarget(self, action: #selector(onTapFailButton), for: .touchUpInside)
    }
    @objc func onTapDoneButton() {
        appendMemos()
    }

    @objc func onTapFailButton() {
    }

    func appendMemos() {
        let now = Date.currentNumericLocalizedDateTime

        var memos: [String: String] = UserDefaults.standard.dictionary(forKey: "memos") as? [String: String] ?? [:]
        if !memos.isEmpty {
            UserDefaults.standard.removeObject(forKey: "memos")
        }
        memos[now] = memoView.text!
        UserDefaults.standard.set(memos, forKey: "memos")
    }
}

// MARK: - Delegate
extension CallCheckViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = .label
        textView.text = nil
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "텍스트 입력"
            textView.textColor = .placeholderText
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
}
