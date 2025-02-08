//
//  ContentView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI

struct CarsListView: View {
    @StateObject private var viewModel = CarViewModel()
                            
    var body: some View {
        
        VStack{
            Text("test")
            
            List(viewModel.cars, id: \.model) { car in
                HStack{
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("\(car.brand) \(car.model)")
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
