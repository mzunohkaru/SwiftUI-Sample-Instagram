//
//  PostService.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct PostService {
    
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await FirebaseConstants
            .PostsCollection
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        var posts = try snapshot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0 ..< posts.count {
            let post = posts[i]
            // 取得した post から所有者のユーザーID（ownerUid）を取得
            let ownerUid = post.ownerUid
            // 所有者のユーザー情報を取得
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            // 取得したユーザー情報を元の投稿に追加
            posts[i].user = postUser
        }
        
        return posts
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        
        let snapshot = try await FirebaseConstants
            .PostsCollection
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
    }
    
    static func fetchPost(_ postId: String) async throws -> Post {
        return try await FirebaseConstants
            .PostsCollection
            .document(postId)
            .getDocument(as: Post.self)
    }
}

extension PostService {
    
    static func likePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await FirebaseConstants
            .PostsCollection
            .document(post.id)
            .collection("post-likes")
            .document(uid)
            .setData([:])
        
        async let _ = try await FirebaseConstants
            .PostsCollection
            .document(post.id)
            .updateData(["likes": post.likes + 1])
        
        async let _ = FirebaseConstants
            .UsersCollection
            .document(uid)
            .collection("user-likes")
            .document(post.id)
            .setData([:])
    }
    
    static func unlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await FirebaseConstants
            .PostsCollection
            .document(post.id)
            .collection("post-likes")
            .document(uid)
            .delete()
        
        async let _ = try await FirebaseConstants
            .PostsCollection
            .document(post.id)
            .updateData(["likes": post.likes - 1])
        
        async let _ = FirebaseConstants
            .UsersCollection
            .document(uid)
            .collection("user-likes")
            .document(post.id)
            .delete()
    }
    
    static func checkIfUserLikedPost(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await FirebaseConstants
            .UsersCollection
            .document(uid)
            .collection("user-likes")
            .document(post.id)
            .getDocument()
        
        return snapshot.exists
    }
}
