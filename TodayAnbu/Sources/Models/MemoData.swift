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
        MemoData(day: 9, description: "아버지가 홍삼캔디를 먹고 혀가 부었다고 한다. 홍삼 선물은 주지 말아야겠다"),
        MemoData(day: 11, description: "자두자두자두자두"),
        MemoData(day: 1, description: "환율이 너무 높아 이러다 우리 다 죽어"),
        MemoData(day: 8, description: "사우디의 적극적인 증산 계획이 없으면 원유는 그대로"),
        MemoData(day: 10, description: "청년역세권주택 안 됐다 진짜 누가 되는걸까 궁금하다 나 빼고 다 되는듯 이거 몇줄까지 되는거지 한번 계속 해봐야겠따. 근데 아직도 안 너믄ㄴ다 한번더 길게 하 면 어떻게 끗날지 ㅎㅘ긴 가능할 껏 같다"),
        MemoData(day: 18, description: "자본주의적이군요"),
        MemoData(day: 19, description: "이디야는 망고빙수 맛집이다"),
        MemoData(day: 13, description: "하디는 V로그를 한다. 영상 참조"),
        MemoData(day: 4, description: "루미는 아프지 마십셔~"),
        MemoData(day: 44, description: "이번엔 진짜")
    ]
}
