//
//  CarDetailViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//

import Foundation

import SwiftData
import SwiftUI


class CarDetailViewModel: ObservableObject {
    private var modelContext: ModelContext
    
    @Published var isFavorite = false
    var car: Car
    
    init(car: Car, modelContext: ModelContext) {
        self.car = car
        self.modelContext = modelContext
        checkIfFavorite()
    }
    
    func toggleFavorite() {
        if isFavorite {
            if let savedCar = fetchSavedCar() {
                modelContext.delete(savedCar)
                isFavorite = false
            }
        } else {
            modelContext.insert(car)
            isFavorite = true
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Fehler beim Speichern: \(error.localizedDescription)")
        }
    }
    
    private func checkIfFavorite() {
        if fetchSavedCar() != nil {
            isFavorite = true
        }
    }
    
    private func fetchSavedCar() -> Car? {
        let brand = car.brand
        let model = car.model
        
        let fetchRequest = FetchDescriptor<Car>(
            predicate: #Predicate { $0.brand == brand && $0.model == model }
        )
        
        return try? modelContext.fetch(fetchRequest).first
    }
}
