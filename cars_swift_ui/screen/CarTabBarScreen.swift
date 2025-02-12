//
//  CarTabBarScreen.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 10.02.25.
//

import SwiftUI

struct CarTabBarScreen: View {
    var body: some View {
        TabView {
            
            NavigationStack {
                CarsListScreen()
            }.tabItem {
                    Image(systemName: "car")
                    Text("All Cars")
                }
            
            Text("Show favorites (implementation to be continued)")
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            LoginScreen()
                .tabItem {
                    Image(systemName: "person")
                    Text("Login")
                }
        }
    }
}

#Preview {
    CarTabBarScreen()
}
