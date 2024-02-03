//
//  Notification.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/03.
//

import FirebaseFirestore

struct Notification: Identifiable, Codable {
    
    let id: String
    var postId: String?
    let timestamp: Timestamp
    let notificationSenderUid: String
    let type: NotificationType
    
    var post: Post?
    var user: User?
}
