//
//  LogInButton.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 18.02.25.
//

import SwiftUI

struct LogInButtonView: View {
    @Environment(\.colorScheme) private var colorSchema
    var imageName: String?
    var systemImageName: String?
    var action: () -> Void
    
    init(imageName: String, action: @escaping () -> Void) { self.imageName = imageName; self.action = action }
    
    init(systemImageName: String, action: @escaping () -> Void) { self.systemImageName = systemImageName; self.action = action }
    
    var body: some View {
        Button {
            action()
        } label: {
            Group {
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                } else if let systemImageName = systemImageName {
                    Image(systemName: systemImageName)
                        .font(.title2)
                        .foregroundColor(colorSchema == .dark ? .black : .white)
                }
            }
            .frame(width: 40, height: 40)
            .padding(10)
            .background(Color.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
            )
            .shadow(color: Color("contrastColor").opacity(0.2), radius: 5, x: 0, y: 3)
        }
    }
}

#Preview {
    LogInButtonView(imageName: "github_logo") {
        print("test")
    }
}
