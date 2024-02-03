//
//  UploadPostViewModel.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/24.
//

import Foundation
import PhotosUI
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

//すべてのプロパティとメソッドは常にメインスレッドで実行
@MainActor
class UploadPostViewModel: ObservableObject {
    
    @Published var selectedImage: PhotosPickerItem? {
        // 選択された写真アイテムを取得するたびに呼ばれる
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        // 画像が選択されているか確認
        guard let item = item else { return }
        // 画像データを取得
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        // UIImageの作成
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        
        let postRef = FirebaseConstants
            .PostsCollection
            .document()
        
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        
        let post = Post(
            id: postRef.documentID,
            ownerUid: uid,
            caption: caption,
            likes: 0,
            imageUrl: imageUrl,
            timestamp: Timestamp())
        
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        try await postRef.setData(encodedPost)
        
        selectedImage = nil
    }
}
