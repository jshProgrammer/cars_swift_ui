//
//  CarDetailView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI

struct CarDetailView : View {
    var car: Car
    
    var body: some View {
    HStack {
            Image(systemName: "car")
                
            VStack {
                Text("Price from: \(car.price)€")
                Text("Year: \(car.year)")
                Text("FuelType: \(car.fuelType)")
                Text("Horsepower: \(car.horsepower)hp")
                Text("Car type: \(car.carType)")
                Text("Transmission: \(car.transmission)")
            }.padding()
        }
            
    }
}

#Preview {
    CarDetailView(car: PreviewData().loadCars()[0])
}
