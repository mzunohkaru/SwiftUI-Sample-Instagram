//
//  EditProfileViewModel.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore

@MainActor
class EditProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    @Published var selectedImage: PhotosPickerItem? {
        // 選択された写真アイテムを取得するたびに呼ばれる
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var fullname = ""
    @Published var bio = ""
    @Published var profileImage: Image?
    
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        
        if let fullname = user.fullname {
            self.fullname = fullname
            
            if let bio = user.bio {
                self.bio = bio
            }
        }
    }
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        // 画像が選択されているか確認
        guard let item = item else { return }
        // 画像データを取得
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        // UIImageの作成
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        // update profile image if changed
        
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        // update name if changed
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await FirebaseConstants
                .UsersCollection
                .document(user.id)
                .updateData(data)
        }
    }
}
