//
//  ContentView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI

struct CarsListView: View {
    @StateObject private var viewModel = CarViewModel()
                   
    //TODO add filter option and add to favourite
        // implement storage for this
    var body: some View {
        
        NavigationView{
            List(viewModel.cars, id: \.model) { car in
                NavigationLink {
                    CarDetailView(car: car)
                } label: {
                    HStack{
                        Image(systemName: "car")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("\(car.brand) \(car.model)")
                    }
                }
            }.onAppear() {
                viewModel.fetchAllCars()
            }
            .padding()
        }
    }
}

#Preview {
    CarsListView()
}
