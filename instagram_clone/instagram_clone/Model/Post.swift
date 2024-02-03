//
//  Post.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import Foundation
import FirebaseFirestore

struct Post: Identifiable, Hashable, Codable {
    
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    var user: User?
    
    var didLike: Bool? = false
}

extension Post {
    static var MOCK_POSTS: [Post] = [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is First Album", likes: 123, imageUrl: "post-1", timestamp: Timestamp(), user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is Second Album", likes: 22, imageUrl: "post-2", timestamp: Timestamp(), user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "ドジャースで頑張ります", likes: 908, imageUrl: "user-2", timestamp: Timestamp(), user: User.MOCK_USERS[1]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Hello", likes: 560, imageUrl: "user-3", timestamp: Timestamp(), user: User.MOCK_USERS[2]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is Third Album", likes: 3, imageUrl: "post-3", timestamp: Timestamp(), user: User.MOCK_USERS[0]),
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "Football BOT", likes: 560, imageUrl: "user-3", timestamp: Timestamp(), user: User.MOCK_USERS[3]),
    ]
}
