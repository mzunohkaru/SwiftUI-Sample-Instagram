//
//  MainTabView.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedIndex == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedIndex == 0 ? .fill : .none)
                }
                .onAppear {
                    selectedIndex = 0
                }
                .tag(0)
            
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
                .onAppear {
                    selectedIndex = 1
                }
                .tag(1)
            
            UploadPostView(tabIndex: $selectedIndex)
                .tabItem {
                    Image(systemName: selectedIndex == 2 ? "plus.square.fill" : "plus.square")
                        .environment(\.symbolVariants, selectedIndex == 2 ? .fill : .none)
                }
                .onAppear {
                    selectedIndex = 2
                }
                .tag(2)
            
            NotificationsView()
                .tabItem {
                    Image(systemName: selectedIndex == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedIndex == 3 ? .fill : .none)
                }
                .onAppear {
                    selectedIndex = 3
                }
                .tag(3)
            
            CurrentUserProfileView(user: user)
                .tabItem {
                    Image(systemName: selectedIndex == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedIndex == 4 ? .fill : .none)
                }
                .onAppear {
                    selectedIndex = 4
                }
                .tag(4)
        }
        .accentColor(.black)
    }
}

#Preview {
    MainTabView(user: User.MOCK_USERS[0])
}
