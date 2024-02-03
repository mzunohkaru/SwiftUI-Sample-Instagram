//
//  FeedCell.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import SwiftUI

struct FeedCell: View {
    
    // @ObservedObject : ビューモデルの変更を監視し、ビューモデル内のデータが変更された場合にビューを更新するために使用されます
    @ObservedObject var viewModel: FeedCellViewModel
    
    @State private var showComments = false
    
    // postデータにアクセスする
    private var post: Post {
        // ビューモデルからpostデータを取得します
        // ビューモデル内のpostデータを返します
        return viewModel.post
    }
    
    private var didLike: Bool {
        return post.didLike ?? false
    }
    
    // postは、外部からFeedCellに渡されるデータ
    init(post: Post) {
        // FeedCellViewModelは、FeedCellのビューモデルであり、ビューに表示するデータを管理します
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            // image + username
            HStack {
                if let user = post.user {
                    
                    CirularProfileImageView(user: user, size: .small)
                    
                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            
            // post image (投稿には、画像が必ず存在する)
            
            if let imageUrl = URL(string: post.imageUrl) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 400)
            }else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(height: 400)
                    .foregroundColor(Color(.systemGray4))
            }
            
            // action buttons
            HStack(spacing: 16) {
                Button {
                    handleLikeTapped()
                } label: {
                    Image(systemName: didLike ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundColor(didLike ? .red : .black)
                }
                
                Button {
                    showComments.toggle()
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                
                Button {
                    ShareLink(item: URL(string: "https://www.youtube.com/watch?v=7UKUCZuaVlA&t=9495s")!)
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(.black)
            
            // likes label
            
            if post.likes > 0 {
                NavigationLink {
                    UserListView(config: UserListConfig.likes(postId: post.id))
                } label: {
                    Text("\(post.likes) likes")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 10)
                        .padding(.top, 1)
                }
            }
            
            // caption label
            
            HStack {
                Text("\(post.user?.username ?? "") ")
                    .fontWeight(.semibold) +
                Text(post.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading, 10)
            .padding(.top, 1)
            
            Text(post.timestamp.timestampString())
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
                .foregroundColor(.gray)
        }
        .sheet(isPresented: $showComments, content: {
            CommentsView(post: post)
            // sheet の bar
                .presentationDragIndicator(.visible)
        })
    }
    
    private func handleLikeTapped() {
        Task {
            if didLike {
                try await viewModel.unlike()
            } else {
                try await viewModel.like()
            }
        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POSTS[0])
}
