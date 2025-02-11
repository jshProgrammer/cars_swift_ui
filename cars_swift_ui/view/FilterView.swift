//
//  FilterView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 09.02.25.
//

import SwiftUI

//TODO implement function that stores the latest filters to add them as suggestions
struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var carViewModel: CarViewModel
    @ObservedObject var carFilter: CarFilterObservable
    
    @State private var isEditingPrice = false
    
    init(viewModel: CarViewModel) {
            self.carViewModel = viewModel
            self.carFilter = viewModel.carFilter
    }
    
    var body: some View {
        
        //TODO: add range slider for ps and year, picker for brand and model
        //TODO: perhaps add arrays for filter options
        
        NavigationStack {
            
            VStack {
                Text("Car Type")
                    .font(.headline)
                
                Picker("Car Type", selection: $carFilter.carType) {
                    ForEach(Car.CarType.allCases, id: \.self) { carType in
                        Text(carType.rawValue).tag(carType)
                    }
                }.pickerStyle(.segmented)
            }.padding()
            
            HStack{
                Text("Transmission Type")
                    .font(.headline)
                
                Picker("Transmission Type", selection: $carFilter.transmissionType) {
                    ForEach(Car.Transmission.allCases, id: \.self) { transmissionType in
                        Text(transmissionType.rawValue).tag(transmissionType)
                    }
                }
                
            }
            
            VStack {
                Text("Fuel Type")
                    .font(.headline)
                
                Picker("Fuel Type", selection: $carFilter.fuelType) {
                    ForEach(Car.FuelType.allCases, id: \.self) { fuelType in
                        Text(fuelType.rawValue).tag(fuelType)
                    }
                }.pickerStyle(.segmented)
            }.padding()
            
        
            
            VStack {
                Text("Max Price")
                    .font(.headline)
                Slider(value: $carFilter.maxPrice, in: 0...200000, step: 500) {
                    Text("Max Price")
                } minimumValueLabel: {
                    Text("0€")
                } maximumValueLabel: {
                    Text("200,000€")
                } onEditingChanged: { editing in
                    isEditingPrice = editing
                }
                Text("\(Int(carFilter.maxPrice))€")
                    .foregroundColor(isEditingPrice ? .blue : .black)
                
            }
            .padding()
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        carViewModel.carFilter = carFilter
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    let dummyViewModel = CarViewModel()
    
    
   return FilterView(viewModel: dummyViewModel)
}
