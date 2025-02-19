//
//  PreviewData.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 09.02.25.
//

import Foundation

struct PreviewData {
    func loadSampleRating() -> Rating {
        return Rating(amountOfStars: 4, ratingHeadline: "Incredible", ratingDescription: "Wow it is such a great car, I absolutely adore it")
    }
    
    func loadCars() -> [Car] {
        
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url);
            let cars = try JSONDecoder().decode([DecodableCar].self, from: data)
            return cars.map { decodableCar in
                Car(from: decodableCar)
            }
        } catch {
            return []
        }
    }
}
