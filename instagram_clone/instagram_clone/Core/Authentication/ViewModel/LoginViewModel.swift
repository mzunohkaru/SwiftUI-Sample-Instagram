//
//  LoginViewModel.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
