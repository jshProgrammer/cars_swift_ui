//
//  AuthenticationScreen.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//

import SwiftUI

struct AuthenticationScreen: View {
    @EnvironmentObject var authenticationViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                if(authenticationViewModel.authenticationState == .authenticated) {
                    LoggedInScreen()
                        .environmentObject(authenticationViewModel)
                        .offset(y: 0)
                        .transition(.move(edge: .bottom))
                    
                } else {
                    LoginScreen()
                        .environmentObject(authenticationViewModel)
                        .offset(y: 0)
                        .transition(.move(edge: .top))
                }
            }
            .animation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0).delay(0.1), value: authenticationViewModel.authenticationState)
        }
    }
}

#Preview {
    AuthenticationScreen()
        .environmentObject(AuthViewModel())
}
