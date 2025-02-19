//
//  LoggedInScreen.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//

import SwiftUI

struct LoggedInScreen: View {
    @EnvironmentObject var authenticationViewModel: AuthViewModel
    
    @State private var showSignOutAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Spacer()
                Text("Logged in successfully ... to be continued")
                    .navigationTitle("Welcome")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading, content: {
                            Image(systemName: "house")
                                .frame(width: 25)
                        })
                    }
                
                
                Spacer()
                
                Button(action: {
                    print("sign out")
                    showSignOutAlert = true
                }, label: {
                    Text("Log out")
                        .padding()
                        .foregroundColor(.white)
                        .background(Capsule()
                            .fill(Color("contrastColor").opacity(0.6))
                        )
                        
                })
                
                Spacer()
            }
        }
        .alert(LocalizedStringKey("Your sure you want to log out?"), isPresented: $showSignOutAlert) {
            Button {
                authenticationViewModel.signOut()
            } label: {
                Text("Log out")
            }
            
            Button {
                //dismiss() automatically done
            } label: {
                Text("Cancel")
            }
        }
        
    }
}

#Preview {
    LoggedInScreen()
}
