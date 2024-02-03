//
//  FeedViewModel.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import Foundation
import FirebaseFirestore

class FeedViewModel: ObservableObject {

    @Published var posts = [Post]()

    init() {
        Task { try await fetchPosts() }
    }

    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService.fetchFeedPosts()
    }
}