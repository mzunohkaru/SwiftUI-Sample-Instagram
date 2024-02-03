//
//  ContentViewModel.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/29.
//

import Foundation
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject {
    
    private let service = AuthService.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
        
        
        UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }.store(in: &cancellables)
    }
}
