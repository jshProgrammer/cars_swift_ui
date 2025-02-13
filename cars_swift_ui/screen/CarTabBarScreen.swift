//
//  CarTabBarScreen.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 10.02.25.
//

import SwiftUI

struct CarTabBarScreen: View {
    @EnvironmentObject var authenticationViewModel: AuthViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            
            NavigationStack {
                CarsListScreen()
            }.tabItem {
                    Image(systemName: "car")
                    Text("All Cars")
                }
            
            CarFavoritesScreen()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            AuthenticationScreen()
                .tabItem {
                    Image(systemName: "person")
                    Text("Login")
                }
        }
    }
}

#Preview {
    CarTabBarScreen()
        .environmentObject(AuthViewModel())
        .modelContainer(for: Car.self, isUndoEnabled: true)
}
