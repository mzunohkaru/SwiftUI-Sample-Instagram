//
//  IGTextFieldModifier.swift
//  instagram_clone
//
//  Created by Mizuno Hikaru on 2024/01/23.
//

import SwiftUI

struct IGTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View{
        content
            .font(.subheadline)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 24)
    }
}
