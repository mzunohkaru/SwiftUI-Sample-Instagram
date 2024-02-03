//
//  Constants.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/02.
//

import FirebaseFirestore

struct FirebaseConstants {
    
    static let Root = Firestore.firestore()
    
    static let UsersCollection = Root.collection("users")
    
    static let PostsCollection = Root.collection("posts")
    
    static let FollowingCollection = Root.collection("following")
    static let FollowersCollection = Root.collection("followers")
    
    static let NotificationCollection = Root.collection("notifications")
    
    static func UserNotificationCollection(uid: String) -> CollectionReference {
        return NotificationCollection.document(uid).collection("user-notifications")
    }
}
