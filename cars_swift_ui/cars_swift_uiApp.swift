//
//  cars_swift_uiApp.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        FirebaseApp.configure()
        return GIDSignIn.sharedInstance.handle(url)
    }
    
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
          
          
        return true
      }
}

@main
struct cars_swift_uiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            CarTabBarScreen()
        }
        .environmentObject(AuthViewModel())
        .modelContainer(for: Car.self, isUndoEnabled: true)
    }
}
