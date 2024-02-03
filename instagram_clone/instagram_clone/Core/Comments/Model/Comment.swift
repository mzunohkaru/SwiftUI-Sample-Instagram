//
//  Comment.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/02.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable {
    
    @DocumentID var commentId: String?
    let postOwnerUid: String
    let commentText: String
    let postId: String
    let timestamp: Timestamp
    let commentOwnerUid: String
    
    var user: User?
    
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
}
