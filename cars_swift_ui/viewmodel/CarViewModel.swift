//
//  CarViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import Foundation

class CarViewModel: ObservableObject {
    @Published var allCars: [Car] = []
    @Published var cars: [Car] = []
    @Published var isLoading: Bool = true
    
    //TODO: add all as option for enums
    @Published var carFilter: CarFilterObservable = CarFilterObservable()
    
    @Published var searchText: String = ""
    
    init() {
        $searchText
            //.debounce(for: 0.3, scheduler: RunLoop.main) //only if later connected to API
            .map { searchText in
                if searchText.isEmpty {
                    return self.allCars
                } else {
                    return self.allCars.filter { car in
                        car.model.localizedCaseInsensitiveContains(searchText) ||
                        car.brand.localizedCaseInsensitiveContains(searchText)
                    }
                }
            }
            .assign(to: &$cars)
        
        $carFilter
            .map { carFilterObservable in
                return self.allCars.filter{ car in
                        let matchesPrice = car.price <= Int(carFilterObservable.maxPrice)
                        let matchesFuel = carFilterObservable.fuelType == nil || car.fuelType == carFilterObservable.fuelType
                        let matchesCarType = carFilterObservable.carType == nil || car.carType == carFilterObservable.carType
                        let matchesTransmission = carFilterObservable.transmissionType == nil || car.transmission == carFilterObservable.transmissionType
                        
                        return matchesPrice && matchesFuel && matchesCarType && matchesTransmission
                }
            }
            .assign(to: &$cars)
    }
    
    func fetchAllCars() {
        isLoading = true;
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("File data.json not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedCars = try JSONDecoder().decode([DecodableCar].self, from: data)
            //TODO: implement standard case => all cars, no filter applied
            self.allCars = decodedCars.map({ decodableCar in
                Car(from: decodableCar)
            })
            self.cars = allCars
        } catch {
            print("Error when loading and decoding: \(error)")
            return
        }
        self.isLoading = false
    }
}
