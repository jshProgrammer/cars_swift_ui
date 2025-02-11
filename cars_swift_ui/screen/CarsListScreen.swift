//
//  ContentView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI

struct CarsListScreen: View {
    @StateObject private var carViewModel = CarViewModel()
    
    @State private var showFilterOptions = false
    
    //TODO: add implementation, do not always show search bar
    @State private var showSearchBar = false
                   
    var body: some View {
        
        NavigationView{
            VStack {
                if carViewModel.isLoading {
                    ProgressView("Loading cars...")  // ⬅️ Ladeindikator während fetchAllCars()
                } else if(carViewModel.cars.isEmpty) {
                    Text("Could not find any cars")
                } else {
                    List(carViewModel.cars, id: \.model) { car in
                        NavigationLink {
                            CarDetailView(car: car)
                        } label: {
                            CarCellView(car: car)
                        }
                    }.listStyle(.plain)
                }
            }
            .onAppear() {
                carViewModel.fetchAllCars()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showFilterOptions.toggle()
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showSearchBar.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .sheet(isPresented: $showFilterOptions) {
                FilterView(viewModel: carViewModel)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
            .searchable(text: $carViewModel.searchText, prompt: "Search for car name") {
                if(carViewModel.cars.count == 0) {
                    Text("Could not find any relating cars")
                } else {
                    ForEach(carViewModel.cars, id: \.self) { car in
                        NavigationLink {
                            CarDetailView(car: car)
                        } label: {
                            CarCellView(car: car)
                        }
                    }.foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    CarsListScreen()
}
