//
//  Car.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import Foundation
import SwiftData

@Model
class Car {
    @Attribute(.unique) var id: UUID = UUID()
    var brand: String = ""
    var model: String = ""
    var horsepower: Int = 0
    var year: Int = 0
    
    // enums internally stored as Strings by SwiftData, but still available as enums
    var fuelTypeRaw: String = FuelType.gasoline.rawValue
    var fuelType: FuelType {
        get {
            FuelType(rawValue: fuelTypeRaw) ?? .gasoline
        }
        set {
            fuelTypeRaw = newValue.rawValue
        }
    }
    var price: Int = 0
    var imageString: String = ""
    
    var imageURL: URL {
        get {
            let imageURL = URL(string: imageString)
            return imageURL ?? URL(string: "https://www.apple.com")!
        }
        set {
            imageString = imageURL.absoluteString
        }
    }
    
    var transmissionRaw: String = Transmission.automatic.rawValue
    var transmission: Transmission {
        get {
            Transmission(rawValue: transmissionRaw) ?? .automatic
        }
        set {
            transmissionRaw = newValue.rawValue
        }
    }

    var carTypeRaw: String = CarType.sedan.rawValue
    var carType: CarType {
        get {
            CarType(rawValue: carTypeRaw) ?? .sedan
        }
        set {
            carTypeRaw = newValue.rawValue
        }
    }


    enum FuelType: String, Decodable, CaseIterable {
        case gasoline = "Gasoline"
        case electric = "Electric"
        case hybird = "Hybrid"
    }
    
    enum Transmission: String, Codable, CaseIterable {
        case automatic = "Automatic"
        case manual = "Manual"
    }
    enum CarType: String, Codable, CaseIterable {
        case coupe = "Coupe"
        case suv = "SUV"
        case sedan = "Sedan"
        case van = "Van"
        case pickup = "Pickup"
    }
    
    init() {}
    
    init(brand: String, model: String, horsePower: Int, year: Int, fuelType: FuelType, imageString: String, transmission: Transmission, carType: CarType) {
        self.brand = brand
        self.model = model
        self.horsepower = horsePower
        self.year = year
        self.fuelType = fuelType
        self.imageString = imageString
        self.transmission = transmission
        self.carType = carType
    }
    
    convenience init(from decodableCar: DecodableCar) {
            self.init()
            self.brand = decodableCar.brand
            self.model = decodableCar.model
            self.horsepower = decodableCar.horsepower
            self.year = decodableCar.year
            self.fuelType = decodableCar.fuelType
            self.price = decodableCar.price
            self.imageString = decodableCar.image
            self.transmission = decodableCar.transmission
            self.carType = decodableCar.carType
        }
    
    /*enum CodingKeys: String, CodingKey {
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
    }*/
    
    func convertPriceToString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        return formatter.string(from: NSNumber(value: self.price)) ?? "N/A"
    }
}
