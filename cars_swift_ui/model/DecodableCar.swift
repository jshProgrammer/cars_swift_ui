//
//  DecodableCar.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 13.02.25.
//

import Foundation
import SwiftData

struct DecodableCar: Decodable {
    var brand: String
    var model: String
    var horsepower: Int
    var year: Int
    var fuelType: Car.FuelType
    var price: Int
    var image: String
    var transmission: Car.Transmission
    var carType: Car.CarType
    
}


func loadCars(from jsonData: Data, context: ModelContext) throws {
    let decoder = JSONDecoder()
    let decodedCars = try decoder.decode([DecodableCar].self, from: jsonData)
    
    for decodableCar in decodedCars {
        let car = Car(from: decodableCar)
        //context.insert(car)
    }
}
