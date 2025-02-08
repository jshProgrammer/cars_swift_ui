//
//  Car.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import Foundation

struct Car: Decodable {
    var brand: String
    var model: String
    var horsepower: Int
    var year: Int
    var fuelType: FuelType
    var price: Int
    var image: String
    var transmission: Transmission
    var carType: CarType
    
    enum FuelType: String, Decodable {
        case gasoline = "Gasoline"
        case electric = "Electric"
        case hybird = "Hybrid"
    }
    
    enum Transmission: String, Decodable { 
        case automatic = "Automatic"
        case manual = "Manual"
    }
    enum CarType: String, Decodable {
        case coupe = "Coupe"
        case suv = "SUV"
        case sedan = "Sedan"
        case van = "Van"
    }
}
