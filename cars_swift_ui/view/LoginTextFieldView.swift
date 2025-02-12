//
//  LoginTextFieldView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 12.02.25.
//

import SwiftUI

struct LoginTextFieldView: View {
    
    @Binding var text: String
    var hint: String
    var icon: Image
    var isPassword: Bool = false
    
    var body: some View {
        HStack(spacing: 15) {
            icon
                .foregroundColor(.gray)
                .frame(width: 35, alignment: .leading)
            
            if isPassword {
                SecureField(hint, text: $text)
            } else {
                TextField(hint, text: $text)
            }
            
        }
        .padding()
        .background(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)).fill(Color.gray.opacity(0.1)))
            
    }
}

#Preview {
    LoginTextFieldView(text: .constant("Email"), hint: "Email", icon: Image(systemName: "mail"), isPassword: false)
}
