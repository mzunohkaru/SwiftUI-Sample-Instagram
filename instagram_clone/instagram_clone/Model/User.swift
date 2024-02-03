//
//  User.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import Foundation
import FirebaseAuth

struct User: Identifiable, Hashable, Codable {
    var id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    var email: String
    
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

struct UserStats: Codable, Hashable {
    var followingCount: Int
    var followersCount: Int
    var postsCount: Int
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "rena", profileImageUrl: "user-1", fullname: "moriya rena", bio: "Nice to meet you", email: "rena@gmail.com"),
        .init(id: NSUUID().uuidString, username: "sho", profileImageUrl: "user-2", fullname: "Ohtani Shohei", bio: "ドジャース !!!", email: "shohei@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Beckham", profileImageUrl: "user-3", fullname: "David Beckham", bio: "Official", email: "beckham@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Beckham Fan", profileImageUrl: nil, fullname: nil, bio: nil, email: "fan@gmail.com"),
    ]
}
