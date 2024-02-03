//
//  RegistrationViewModel.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
}
