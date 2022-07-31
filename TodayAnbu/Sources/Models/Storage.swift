//
//  Storage.swift
//  TodayAnbu
//
//  Created by taekkim on 2022/07/31.
//

import Foundation

class Storage {
    static var goToOnborading: Bool {
        let defaults = UserDefaults.standard
        return (defaults.object(forKey: "momPhoneNumber") == nil) && (defaults.object(forKey: "dadPhoneNumber") == nil) }
}
