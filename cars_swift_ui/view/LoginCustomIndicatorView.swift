//
//  LoginCustomIndicatorView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 12.02.25.
//

import SwiftUI

struct LoginCustomIndicatorView: View {
    var totalPages: Int
    var currentPage: Int
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<totalPages, id: \.self) { counter in
                Circle()
                    .fill(counter == currentPage ? .black : .gray.opacity(0.3))
                    .frame(width: 4, height: 4)
            }
        }
    }
}

#Preview {
    LoginCustomIndicatorView(totalPages: 2, currentPage: 1)
}
