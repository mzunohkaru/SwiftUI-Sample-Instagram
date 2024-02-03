//
//  ProfileView.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var body: some View {
        ScrollView {
            
            ProfileHeaderView(user: user)
            
            // post grid view
            
            PostGridView(user: user)
            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
