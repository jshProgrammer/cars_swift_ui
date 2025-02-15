//
//  ContentView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI

struct CarsListScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var carViewModel = CarViewModel()
    
    @State private var showFilterOptions = false
    @State private var showSearchBar = false
    
    @ViewBuilder
    private var content: some View {
        
        NavigationView{
            VStack {
                if carViewModel.isLoading {
                    ProgressView("Loading cars...")
                } else if(carViewModel.cars.isEmpty) {
                    Text("Could not find any cars")
                } else {
                    List(carViewModel.cars, id: \.model) { car in
                        NavigationLink {
                            CarDetailScreen(car: car, modelContext: modelContext)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showFilterOptions.toggle()
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showSearchBar.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .navigationTitle("All Cars")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showFilterOptions) {
                FilterView(viewModel: carViewModel)
            }
            
        }
    }
              
    var body: some View {
        NavigationStack {
            if showSearchBar {
                content.searchable(text: $carViewModel.searchText, prompt: "Search for car name") {
                    if(carViewModel.cars.count == 0) {
                        Text("Could not find any relating cars")
                    } else {
                        ForEach(carViewModel.cars, id: \.self) { car in
                            NavigationLink {
                                CarDetailScreen(car: car, modelContext: modelContext)
                            } label: {
                                CarCellView(car: car)
                            }
                        }.foregroundColor(.black)
                    }
                }
            } else {
                content
            }
        }
    }
    
}

#Preview {
    CarsListScreen()
        .modelContainer(for: Car.self, isUndoEnabled: true)
}
