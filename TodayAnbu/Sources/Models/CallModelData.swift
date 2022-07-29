//
//  CallModelData.swift
//  TodayAnbu
//
//  Created by Jisu Jang on 2022/07/28.
//

import Foundation
import Combine


struct CallData {
    var isMomCall: Bool = false
    var isDadCall: Bool = false
    var momCheckCount: Int = 0
    var dadCheckCount: Int = 0
}

class CallManager: ObservableObject {
    @Published var data = CallData()
    static let shared = CallManager()
}

//class CallData: ObservableObject {
//    @Published var isMomCall: Bool = false
//    @Published var isDadCall: Bool = false
//    @Published var momCheckCount: Int = 0
//    @Published var dadCheckCount: Int = 0
//}
//
//class CallManager2 {
//    var data = CallData()
//    static let shared = CallManager2()
//}
