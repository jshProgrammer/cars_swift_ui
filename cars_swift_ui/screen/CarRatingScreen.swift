//
//  CarRatingView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import SwiftUI

struct CarRatingScreen: View {
    var car: Car
    @StateObject var carRatingViewModel: CarRatingViewModel
    @State var addRating: Bool = false
    
    init(car: Car) {
        self.car = car
        _carRatingViewModel = StateObject(wrappedValue: CarRatingViewModel(car: car))
    }
    
    var body: some View {       
        NavigationStack {
            VStack {
                
                HStack {
                    Text("User ratings")
                        .font(.title)
                    
                    Button(action: {
                        addRating = true
                    }, label: {
                        Image(systemName: "plus")
                            .frame(width: 25)
                            .padding(.trailing, 5)
                    })
                }
                
                
                content
            }.sheet(isPresented: $addRating, content: {
                AddCarRatingView(car: car)
                    .presentationDetents([.medium, .large])
            })
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
    CarRatingScreen(car: PreviewData().loadCars()[0])
}
