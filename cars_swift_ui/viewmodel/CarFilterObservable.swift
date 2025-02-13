//
//  CarFilterObservable.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 11.02.25.
//

import Foundation

class CarFilterObservable: ObservableObject {
    @Published var brand: String = "All"
    @Published var model: String = "All"
    @Published var maxPrice: Double = 200000
    @Published var minHorsepower: Int = 100
    @Published var maxHorsepower: Int = 1200
    @Published var minYear: Int = 1990
    @Published var maxYear: Int = Calendar.current.component(.year, from: Date())
    @Published var fuelType: Car.FuelType = .all
    @Published var carType: Car.CarType = .all
    @Published var transmissionType: Car.Transmission = .all
}
