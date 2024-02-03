//
//  CirularProfileImageView.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import SwiftUI

enum ProfileImageSize {
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimension: CGFloat {
        switch self {
        case .xxSmall: return 28
        case .xSmall: return 32
        case .small: return 40
        case .medium: return 48
        case .large: return 64
        case .xLarge: return 80
        }
    }
}

struct CirularProfileImageView: View {
    
    var user: User?
    
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrlString = user?.profileImageUrl,
           // 渡された文字列が有効なURLである場合に新しいURLオブジェクトを返します
           let imageUrl = URL(string: imageUrlString) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            } placeholder: {
//                ProgressView()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: size.dimension, height: size.dimension)
                    .foregroundColor(Color(.systemGray4))
            }
            .frame(width: size.dimension, height: size.dimension)
        }else {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: size.dimension, height: size.dimension)
                .foregroundColor(Color(.systemGray4))
        }
    }
}
