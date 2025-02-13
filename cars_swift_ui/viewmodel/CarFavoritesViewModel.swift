//
//  CarFavoritesViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//

import Foundation

import SwiftData

class CarFavoritesViewModel: ObservableObject {
    //TODO: add @Query
    @Published var cars: [Car] = PreviewData().loadCars()
    
    init() {}
    
    func getAllFavoriteCars() -> [Car] {
        return []
        
        
    }
    
}
