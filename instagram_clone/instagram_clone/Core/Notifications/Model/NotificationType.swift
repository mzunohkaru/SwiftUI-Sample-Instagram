//
//  NotificationType.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/03.
//

import Foundation

enum NotificationType: Int, Codable {
    
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return "liked one of your posts."
        case .comment: return "commented on one of your posts."
        case .follow: return "started following you."
        }
    }
}
