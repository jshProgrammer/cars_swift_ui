//
//  ContentView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI

struct CarsListScreen: View {
    @StateObject private var viewModel = CarViewModel()
                   
    //TODO add filter option and add to favourite
        // implement storage for this
    var body: some View {
        
        NavigationView{
            List(viewModel.cars, id: \.model) { car in
                NavigationLink {
                    CarDetailView(car: car)
                } label: {
                    CarCellView(car: car)
                }
            }.listStyle(.plain)
            .onAppear() {
                viewModel.fetchAllCars()
            }
            .padding()
        }
    }
}

#Preview {
    CarsListScreen()
}
