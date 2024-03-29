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
    @IBOutlet weak var titleBox: UIView!

    private let placeholder = "ex) 어머니에게 최근 먹은 과일에 대해 여쭤보았다!! 어머니가 수박을 좋아하시는 걸 알게 되어서, 여름이 가기 전에 수박을 사드려야겠는걸!!"
    private let tempIsMom = true

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTopBox()
        configureTextView()
        configureButtons()
    }
}

// MARK: - Functions
extension CallCheckViewController {
    func configureTopBox() {
        titleBox.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    func configureTextView() {
        memoView.font = .systemFont(ofSize: 16.0, weight: .regular)
        memoView.text = placeholder
        memoView.textColor = .placeholderText
        memoView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        memoView.layer.masksToBounds = false
        memoView.layer.cornerRadius = 20
        memoView.delegate = self
    }
    func configureButtons() {
        callDoneButton.layer.cornerRadius = 5
        callFailButton.layer.cornerRadius = 5
        callDoneButton.addTarget(self, action: #selector(onTapDoneButton), for: .touchUpInside)
        callFailButton.addTarget(self, action: #selector(onTapFailButton), for: .touchUpInside)
    }
    @objc func onTapDoneButton() {
        appendMemos()
        dismiss(animated: true)
        if CallManager.shared.data.isMomCall {
            var currentData = CallManager.shared.data
            currentData.momCheckCount += 1
            currentData.isMomCall.toggle()
            CallManager.shared.data = currentData
        }

        if CallManager.shared.data.isDadCall {
            var currentData = CallManager.shared.data
            currentData.dadCheckCount += 1
            currentData.isDadCall.toggle()
            CallManager.shared.data = currentData
        }

        var currentData = CallManager.shared.data
        currentData.notCallDate = 0
        // 전화를 하면 notCallDate는 0으로 초기화
        CallManager.shared.data = currentData
        // 전화 후 전화 한 시간 저장
        UserDefaults.standard.set(Date.currentNumericLocalizedDateTime, forKey: "lastCallTime")
        UserDefaults.standard.set(DateFormatter().defaultDate, forKey: "lastCallTimeDateType")
    }

    @objc func onTapFailButton() {
        dismiss(animated: true)
    }

    func appendMemos() {
        let key = tempIsMom ? "momMemo" : "dadMemo"
        let now = Date.currentNumericLocalizedDateTime

        var memos: [String: String] = UserDefaults.standard.dictionary(forKey: key) as? [String: String] ?? [:]
        if !memos.isEmpty {
            UserDefaults.standard.removeObject(forKey: key)
        }
        memos[now] = memoView.text!
        UserDefaults.standard.set(memos, forKey: key)
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
    // 다른 영역 터치할때 나가기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
