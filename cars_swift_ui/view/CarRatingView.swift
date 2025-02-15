//
//  CarRatingView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import SwiftUI

struct CarRatingView: View {
    var car: Car
    @StateObject var carRatingViewModel: CarRatingViewModel
    
    init(car: Car) {
        self.car = car
        _carRatingViewModel = StateObject(wrappedValue: CarRatingViewModel(car: car))
    }
    
    var body: some View {       
        NavigationStack {
            content
        }
    }
    
    @ViewBuilder
    var content: some View {
        if(carRatingViewModel.ratings.isEmpty) {
            Text("No ratings available yet")
        } else {
            ForEach(carRatingViewModel.ratings, id: \.self) { rating in
                CarRatingCellView(car: car, rating: rating)
            }
        }
    }
}

#Preview {
    CarRatingView(car: PreviewData().loadCars()[0])
}
