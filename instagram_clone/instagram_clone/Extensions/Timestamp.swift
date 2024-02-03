//
//  Timestamp.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import FirebaseFirestore

extension Timestamp {
    
    func timestampString() -> String {
        // 時間の間隔を文字列に変換する
        let formatter = DateComponentsFormatter()
        // 時間の単位（秒、分、時間、日、週）を設定
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        // 時間の間隔を表現する際に最大1つの単位しか使用しない ("1 day 10 hours"ではなく、"1 day")
        formatter.maximumUnitCount = 1
        // 時間の単位を省略形で表示 ("seconds"ではなく"sec") ("minutes"ではなく"min")
        formatter.unitsStyle = .abbreviated
        // （self.dateValue()）と現在の日時（Date()）との間の時間の間隔を文字列に変換
        return formatter.string(from: self.dateValue(), to: Date()) ?? ""
    }
}
