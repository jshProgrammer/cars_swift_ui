//
//  CarFilterObservable.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 11.02.25.
//

import Foundation

class CarFilterObservable: ObservableObject {
    @Published var maxPrice: Double = 200000
    @Published var fuelType: Car.FuelType = .electric
    @Published var carType: Car.CarType = .coupe
    @Published var transmissionType: Car.Transmission = .manual
}
