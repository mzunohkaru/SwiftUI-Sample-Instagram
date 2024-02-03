//
//  DeveloperPreview.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/02.
//

import SwiftUI
import FirebaseFirestore

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let comment = Comment(
        postOwnerUid: "123",
        commentText: "テスト投稿です",
        postId: "3214",
        timestamp: Timestamp(),
        commentOwnerUid: "123456789"
    )
    
    let notifications: [Notification] = [
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "123", type: .like),
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "456", type: .comment),
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "789", type: .follow),
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "019", type: .like),
        .init(id: NSUUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "384", type: .like)
    ]
}
