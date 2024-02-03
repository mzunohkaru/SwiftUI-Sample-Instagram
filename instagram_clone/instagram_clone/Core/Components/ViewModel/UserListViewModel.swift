//
//  UserListViewModel.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/02/02.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    
    @Published var users = [User]()
    
    init() {}
    
    func fetchUsers(forConfig config: UserListConfig) async {
        do {
            self.users = try await UserService.fetchUsers(forConfig: config)
        } catch {
            print("DEBUG: Failed to fetch users with error \(error.localizedDescription)")
        }
    }
    
    func filterUsers(with query: String) {
        let lowercaseQuery = query.lowercased()
        self.users = users.filter{
            $0.username.lowercased().contains(lowercaseQuery) ||
            ($0.fullname?.lowercased().contains(lowercaseQuery) ?? false)
        }
    }
}
