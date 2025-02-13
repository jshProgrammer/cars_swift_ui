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
        //TODO: perhaps add arrays for filter options
        
        NavigationStack {
            
            VStack(spacing: 10) {
                
                HStack {
                    Picker("Brand", selection: $carFilter.brand) {
                        Text("All").tag("All")
                        ForEach(carViewModel.fetchAllBrands(), id: \.self) { brand in
                            Text("\(brand)").tag(brand)
                        }
                    }.pickerStyle(.navigationLink)
                        .font(.headline)
                }
                
                HStack {
                    Text("Model")
                        .font(.headline)
                    
                    Spacer()
                    
                    Picker("Model", selection: $carFilter.model) {
                        Text("All").tag("All")
                        ForEach(carViewModel.fetchAllModelsOfBrand(brand: carFilter.brand), id: \.self) { model in
                            Text("\(model)").tag(model)
                        }
                    }.pickerStyle(.menu)
                }
                
                VStack {
                    Text("Year")
                        .font(.headline)
                    
                    RangeSliderView(start: $carFilter.minYear, end: $carFilter.maxYear, bounds: 1990...Calendar.current.component(.year, from: Date()))
                }
            }.padding(.horizontal, 15)
                .foregroundColor(.black)
            
            Divider()
            
            VStack {
                Text("Car Type")
                    .font(.headline)
                
                Picker("Car Type", selection: $carFilter.carType) {
                    ForEach(Car.CarType.allCases, id: \.self) { carType in
                        Text(carType.rawValue).tag(carType)
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
                
            }.padding()
            
            Divider()
            
            
            VStack (spacing: 20) {
                VStack {
                    Text("Fuel Type")
                        .font(.headline)
                    
                    Picker("Fuel Type", selection: $carFilter.fuelType) {
                        ForEach(Car.FuelType.allCases, id: \.self) { fuelType in
                            Text(fuelType.rawValue).tag(fuelType)
                        }
                    }.pickerStyle(.segmented)
                }.padding(.vertical, 10)
            
                
                VStack {
                    Text("Horsepower")
                        .font(.headline)
                    
                    RangeSliderView(start: $carFilter.minHorsepower, end: $carFilter.maxHorsepower, bounds: 0...1200)
                }
                
                HStack{
                    Text("Transmission Type")
                        .font(.headline)
                    
                    Picker("Transmission Type", selection: $carFilter.transmissionType) {
                        ForEach(Car.Transmission.allCases, id: \.self) { transmissionType in
                            Text(transmissionType.rawValue).tag(transmissionType)
                        }
                    }
                    
                }
            }.padding()
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        carViewModel.resetFilter()
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.uturn.left")
                            .frame(width: 20)
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
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
