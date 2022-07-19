//
//  UITextfieldExtension.swift
//  TodayAnbu
//
//  Created by YeongJin Jeong on 2022/07/15.
//

import Foundation
import UIKit

extension UITextField {

    public var hasValidPhoneNumber: Bool {
        return text!.range(of: "^01[0-1, 7][0-9]{7,8}$",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }

    // Textfield Custom을 위한 Extenstion, 아래 줄만 생김
    func setBottomBorder(color: UIColor) {
            self.borderStyle = .none
            self.layer.backgroundColor = UIColor.white.cgColor
            self.layer.masksToBounds = false
            self.layer.shadowColor = color.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0.0
        }

    // Done 버튼 추가하기
    @IBInspectable var doneAccessory: Bool {
            get {
                return self.doneAccessory
            }
            set(hasDone) {
                if hasDone {
                    addDoneButtonOnKeyboard()
                }
            }
        }

        func addDoneButtonOnKeyboard() {

            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            self.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction() {
            self.resignFirstResponder()
        }
}
