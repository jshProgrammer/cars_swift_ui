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
                    let matchesBrand = carFilterObservable.brand == "All" || car.brand == carFilterObservable.brand
                    let matchesModel = carFilterObservable.model == "All" || car.model == carFilterObservable.model
                    let matchesPrice = car.price <= Int(carFilterObservable.maxPrice)
                    let matchesFuel = carFilterObservable.fuelType == .all || car.fuelType == carFilterObservable.fuelType
                    let matchesPS = carFilterObservable.minHorsepower <= car.horsepower && carFilterObservable.maxHorsepower >= car.horsepower
                    let matchesYear = carFilterObservable.minYear <= car.year && carFilterObservable.maxYear >= car.year
                    let matchesCarType = carFilterObservable.carType == .all || car.carType == carFilterObservable.carType
                    let matchesTransmission = carFilterObservable.transmissionType == .all || car.transmission == carFilterObservable.transmissionType
                    
                    return matchesBrand && matchesModel && matchesPrice && matchesFuel && matchesCarType && matchesTransmission && matchesPS && matchesYear
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
    
    func fetchAllBrands() -> [String] {
        return Array(Set(allCars.map { $0.brand })).sorted()
    }
    
    //TODO: implement array of brands as parameter
    func fetchAllModelsOfBrand(brand: String) -> [String] {
        return allCars.filter { car in
            car.brand == brand
        }.map { car in
            car.model
        }
    }
    
    func resetFilter() {
        cars = allCars
        carFilter.brand = "All"
        carFilter.model = "All"
        carFilter.maxPrice = 200000
        carFilter.minHorsepower = 40
        carFilter.maxHorsepower = 1200
        carFilter.minYear = 1990
        carFilter.maxYear = Calendar.current.component(.year, from: Date())
        carFilter.fuelType = .all
        carFilter.carType = .all
        carFilter.transmissionType = .all
        
    }
}
