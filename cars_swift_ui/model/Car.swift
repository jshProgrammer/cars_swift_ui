//
//  Car.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import Foundation

struct Car: Decodable, Hashable {
    var brand: String
    var model: String
    var horsepower: Int
    var year: Int
    var fuelType: FuelType
    var price: Int
    var image: URL
    var transmission: Transmission
    var carType: CarType
    
    enum FuelType: String, Decodable, CaseIterable {
        case gasoline = "Gasoline"
        case electric = "Electric"
        case hybird = "Hybrid"
    }
    
    enum Transmission: String, Decodable, CaseIterable {
        case automatic = "Automatic"
        case manual = "Manual"
    }
    enum CarType: String, Decodable, CaseIterable {
        case coupe = "Coupe"
        case suv = "SUV"
        case sedan = "Sedan"
        case van = "Van"
        case pickup = "Pickup"
    }
    
    enum CodingKeys: String, CodingKey {
        case brand, model, horsepower, year, fuelType, price, image, transmission, carType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        brand = try container.decode(String.self, forKey: .brand)
        model = try container.decode(String.self, forKey: .model)
        horsepower = try container.decode(Int.self, forKey: .horsepower)
        year = try container.decode(Int.self, forKey: .year)
        fuelType = try container.decode(FuelType.self, forKey: .fuelType)
        price = try container.decode(Int.self, forKey: .price)
        transmission = try container.decode(Transmission.self, forKey: .transmission)
        carType = try container.decode(CarType.self, forKey: .carType)
        
        // transform image url string to url
        let imageString = try container.decode(String.self, forKey: .image)
        
        guard let imageURL = URL(string: imageString) else {
            throw DecodingError.dataCorruptedError(forKey: .image, in: container, debugDescription: "Invalid URL string")
        }
        image = imageURL
    }
    
    func convertPriceToString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        return formatter.string(from: NSNumber(value: self.price)) ?? "N/A"
    }
}
