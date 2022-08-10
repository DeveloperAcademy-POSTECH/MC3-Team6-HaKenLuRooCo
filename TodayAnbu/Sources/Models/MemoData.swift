//
//  MemoData.swift
//  TodayAnbu
//
//  Created by Taehwan Kim on 2022/07/27.
//
// MemoView에서 사용하기 위한 더미 Data입니다. 실험이 끝나고 삭제하겠습니다.
import Foundation

struct MemoData: Hashable, Identifiable {
    var id: IndexPath?
    let date: String
    let description: String
}
