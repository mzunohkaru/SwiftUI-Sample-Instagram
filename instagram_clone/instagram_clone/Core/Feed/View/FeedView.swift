//
//  FeedView.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()

    // FeedView と CommentsView と FeedCell で viewModelの生成の違い
    
    // ・ FeedView （ viewModel = FeedViewModel() ）
    // FeedView自体がアプリの起動時に一度だけ作成され、その後は破棄されないような使われ方をするため、
    // アプリのライフサイクルに密接に関連している
    
    // ・ CommentsView （ viewModel: CommentsViewModel ）
    // Viewが初期化される際にViewModelも一緒に初期化され、Viewが破棄されるまでインスタンスが保持されます
    // 特定の投稿に対するコメントを扱うため、投稿ごとに新しいViewModelインスタンスが必要なため、
    // Viewのライフサイクルに密接に関連している
    
    // ・ FeedCell （ @ObservedObject var viewModel: FeedCellViewModel ）
    // 外部から viewModel を受け取り、変更を監視するため
    // ライフサイクルに関連していない
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 32) {
                    ForEach(viewModel.posts) { post in
                        FeedCell(post: post)
                    }
                }
                .padding(.top, 8)
            }
            .refreshable {
                Task { try await viewModel.fetchPosts() }
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("instagram-logo-black")
                        .resizable()
                        .frame(width: 100, height: 62)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    FeedView()
}
