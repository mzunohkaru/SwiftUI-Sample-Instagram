//
//  UserListConfig.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/02.
//

import Foundation

enum UserListConfig: Hashable {
    
    case followers(uid: String)
    case following(uid: String)
    case likes(postId: String)
    case explore
    
    var navigationTitle: String {
        switch self {
        case .followers: return "Followers"
        case .following: return "Following"
        case .likes: return "Likes"
        case .explore: return "Explore"
        }
    }
}
