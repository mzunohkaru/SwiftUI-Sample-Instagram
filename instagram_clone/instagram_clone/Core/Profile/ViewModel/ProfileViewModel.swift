//
//  ProfileViewModel.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/02.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func fetchUserStats() {
        guard user.stats == nil else { return }
        
        Task {
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}

// MARK: - Following

extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
            
            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
            
            await NotificationManager.shared.deleteFollowNotification(notificationOwnerUid: user.id)
        }
    }
    
    func checkIfUserIsFollowed() {
        guard user.isFollowed == nil else { return }
        
        Task {
            self.user.isFollowed = try await UserService.checkIfUserFollowed(uid: user.id)
        }
    }
}
