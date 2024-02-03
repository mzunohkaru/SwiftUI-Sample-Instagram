//
//  NotificationCell.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/03.
//

import SwiftUI

struct NotificationCell: View {
    
    let notification: Notification
    
    var body: some View {
        HStack {
            
            NavigationLink(value: notification.user) {
                CirularProfileImageView(user: notification.user, size: .xSmall)
            }
            
            // notification message
            
            HStack {
                Text(notification.user?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold) +
                
                Text(" \(notification.type.notificationMessage)")
                    .font(.subheadline) +
                
                Text(" \(notification.timestamp.timestampString())")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            
            Spacer()
            
            if notification.type != .follow {
                if let imageUrl = URL(string: notification.post?.imageUrl ?? "") {
                    NavigationLink(value: notification.post) {
                        AsyncImage(url: imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipped()
                                .padding(.leading, 2)
                        }
                    placeholder: {
                        ProgressView()
                    }
                    }
                    
                }
            } else {
                Button {
                    print("DEBUG: Follow")
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 88, height: 32)
                        .foregroundColor(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationCell(notification: DeveloperPreview.shared.notifications[2])
}
