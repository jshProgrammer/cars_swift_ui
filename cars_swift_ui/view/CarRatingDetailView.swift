//
//  CarRatingDetailView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import SwiftUI

struct CarRatingDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var car: Car
    var rating: Rating
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        ForEach(1...5, id: \.self) { num in
                            Image(systemName: num <= rating.amountOfStars ? "star.fill" : "star")
                        }
                    }.foregroundColor(Color("contrastColor"))
                    
                    Text("\n")
                    
                    Text("\(rating.ratingDescription)")
                }.padding()
            }
                .navigationTitle("\(car.brand) \(car.model): \(rating.ratingHeadline)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar() {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
        }
    }
}

#Preview {
    CarRatingDetailView(car: PreviewData().loadCars()[0], rating: PreviewData().loadSampleRating())
}
