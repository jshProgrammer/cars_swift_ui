//
//  CarViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import Foundation

class CarViewModel: ObservableObject {
    @Published var cars: [Car] = []
    
    func fetchAllCars() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("File data.json not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedCars = try JSONDecoder().decode([Car].self, from: data)
            self.cars = decodedCars
        } catch {
            print("Error when loading and decoding: \(error)")
            return
        }
    }
}
