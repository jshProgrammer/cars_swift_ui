//
//  AuthViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import AuthenticationServices

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
    
    func signInWithGoogle(presentingViewController: UIViewController) async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Fehlende Client-ID für Google Sign-In.")
            return false
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        do {
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController)

            let user = result.user
            guard let idToken = user.idToken?.tokenString else {
                print("Fehler: Kein gültiger ID-Token erhalten.")
                return false
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            let authResult = try await Auth.auth().signIn(with: credential)
            self.user = authResult.user
            self.authenticationState = .authenticated
            print("Erfolgreich bei Firebase angemeldet: \(authResult.user.displayName ?? "Kein Name")")
            return true
        } catch {
            print("Fehler bei der Google-Anmeldung: \(error.localizedDescription)")
            return false
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
    
    func signUpWithEmailPassword(email: String, password: String) async -> (Bool, String) {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            user = authResult.user
            print("User \(authResult.user.uid) signed in")
            authenticationState = .authenticated
            return (true, "")
        } catch {
            print("\(error.localizedDescription)")
            authenticationState = .unauthenticated
            return (false, error.localizedDescription)
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
