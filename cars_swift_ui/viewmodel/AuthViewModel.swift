//
//  AuthViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//

import Foundation
import FirebaseAuth

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case signUp
}

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var flow: AuthenticationFlow = .login
    
    @Published var isValid: Bool = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    //@Published var errorMessage: String = ""
    @Published var user: User?
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        registerAuthStateHandler()
    }
    
    func registerAuthStateHandler() {
        if authStateHandle == nil {
            authStateHandle = Auth.auth().addStateDidChangeListener({ auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
            })
        }
    }
    
    func signInWithEmailPassword(email: String, password: String) async -> Bool {
        authenticationState = .authenticating
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return true
        } catch {
            print("\(error.localizedDescription)")
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signUpWithEmailPassword(email: String, password: String) async -> Bool {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return true
        } catch {
            print("\(error.localizedDescription)")
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    
}
