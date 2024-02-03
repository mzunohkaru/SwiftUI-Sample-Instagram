//
//  EditProfileView.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // 型の宣言と同時にインスタンス化を行う
    // @StateObject var viewModel = EditProfileViewModel()
    // 型の宣言と同時にインスタンス化を行わない
    @StateObject var viewModel: EditProfileViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack {
            
            // toolbar
            
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal)
                
                Divider()
            }
            
            // edit profile pic
            
            PhotosPicker(selection: $viewModel.selectedImage,
                         // 画像のみ選択が可能
                         matching: .any(of: [.images, .not(.videos)])) {
                VStack {
                    if let image = viewModel.profileImage {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(.gray)
                            .clipShape(Circle())
                    } else {
                        CirularProfileImageView(user: viewModel.user, size: .xLarge)
                    }
                    
                    Text("Edit profile pic")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Divider()
                }
            }
                         .padding(.vertical, 8)
            
            
            // edit profile info
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name..", text: $viewModel.fullname)
                
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio..", text: $viewModel.bio)
            }
            
            Spacer()
        }
    }
}

struct EditProfileRowView: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            
            VStack {
                TextField(placeholder, text: $text)
                
                Divider()
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
