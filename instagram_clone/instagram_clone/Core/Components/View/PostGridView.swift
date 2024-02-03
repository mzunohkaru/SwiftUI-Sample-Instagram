//
//  PostGridView.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import SwiftUI

struct PostGridView: View {
    
    @StateObject var viewModel: PostGridViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        // post grid view
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(viewModel.posts) { post in
                if let imageUrl = URL(string: post.imageUrl) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageDimension, height: imageDimension)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
        .padding(.horizontal, 2)
    }
}

#Preview {
    PostGridView(user: User.MOCK_USERS[0])
}
