//
//  CommentCell.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/02.
//

import SwiftUI

struct CommentCell: View {
    
    let comment: Comment
    
    private var user: User? {
        return comment.user
    }
    
    var body: some View {
        HStack {
            CirularProfileImageView(user: user, size: .xSmall)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(user?.username ?? "")
                        .fontWeight(.semibold)
                    
                    Text(comment.timestamp.timestampString())
                        .foregroundColor(.gray)
                }
                
                Text(comment.commentText)
            }
            .font(.caption)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    CommentCell(comment: DeveloperPreview.shared.comment)
}
