//
//  CarFavoritesScreen.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//

import SwiftUI
import SwiftData

struct CarFavoritesScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var cars: [Car]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cars) { car in
                    NavigationLink {
                        CarDetailView(car: car, modelContext: modelContext)
                    } label: {
                        CarCellView(car: car)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        modelContext.delete(cars[index])
                    }
                })
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CarFavoritesScreen()
        .modelContainer(for: Car.self, isUndoEnabled: true)
}
