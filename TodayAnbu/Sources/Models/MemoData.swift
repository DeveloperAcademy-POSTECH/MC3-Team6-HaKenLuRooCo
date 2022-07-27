//
//  MemoData.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/27.
//
// MemoView에서 사용하기 위한 더미 Data입니다. 실험이 끝나고 삭제하겠습니다.
import Foundation

struct MemoData: Hashable {
    let day: Int
    let description: String
}

extension MemoData {
    static let list = [
        MemoData(day: 7, description: "오늘은 어머니가 자두가 먹고 싶다고 하셨다."),
        MemoData(day: 6, description: "집에 모기가 많다고 한다"),
        MemoData(day: 3, description: "요즘 자주 두통을 호소하신다"),
        MemoData(day: 5, description: "한달 동안 5번이나 넘어지셨다고 한다. 왜지?"),
        MemoData(day: 9, description: "아버지가 홍삼캔디를 먹고 혀가 부었다고 한다. 홍삼 선물은 주지 말아야겠다")
    ]
}
