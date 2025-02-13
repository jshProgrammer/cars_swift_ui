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
    @Published var fuelType: Car.FuelType = .all
    @Published var carType: Car.CarType = .all
    @Published var transmissionType: Car.Transmission = .all
}
