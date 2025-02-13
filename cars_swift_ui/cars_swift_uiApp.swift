//
//  cars_swift_uiApp.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI
import SwiftData

@main
struct cars_swift_uiApp: App {
    var body: some Scene {
        WindowGroup {
            CarTabBarScreen()
        }
        .modelContainer(for: Car.self, isUndoEnabled: true)
    }
}
