//
//  UserListView.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/02.
//

import SwiftUI

struct UserListView: View {
    
    @State private var searchText = ""
    
    @StateObject var viewModel = UserListViewModel()
    
    private let config: UserListConfig
    
    init(config: UserListConfig) {
        self.config = config
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            CirularProfileImageView(user: user, size: .small)
                            
                            VStack(alignment: .leading) {
                                Text(user.username)
                                    .fontWeight(.semibold)
                                
                                if let fullname = user.fullname {
                                    Text(fullname)
                                }
                            }
                            .font(.footnote)
                            
                            Spacer()
                        }
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 8)
            .searchable(text: $searchText, prompt: "Search...")
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    Task { await viewModel.fetchUsers(forConfig: config) }
                } else {
                    viewModel.filterUsers(with: newValue)
                }
            }
        }
        .task { await viewModel.fetchUsers(forConfig: config) }
    }
}

#Preview {
    UserListView(config: .explore)
}
