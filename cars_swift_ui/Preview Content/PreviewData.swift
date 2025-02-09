//
//  PreviewData.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 09.02.25.
//

import Foundation

struct PreviewData {
    func loadCars() -> [Car] {
        
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url);
            let cars = try JSONDecoder().decode([Car].self, from: data)
            return cars
        } catch {
            return []
        }
    }
}
