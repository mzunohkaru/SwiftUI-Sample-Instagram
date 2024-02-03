//
//  CurrentUserProfileView.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    let user: User
    
    var posts: [Post] {
        // $0 : Post.MOCK_POSTS.filter({})の中で、posts配列の現在処理している各要素を参照します。
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //header
                
                ProfileHeaderView(user: user)
                
                // post grid view
                
                PostGridView(user: user)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        Task { try await AuthService.shared.signout() }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
