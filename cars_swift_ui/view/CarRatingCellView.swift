//
//  CarRatingCellView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import SwiftUI

struct CarRatingCellView: View {
    var car: Car
    var rating: Rating
    @State private var moreDetails: Bool = false
    
    var body: some View {
        
        HStack {
            HStack {
                ForEach(1...5, id: \.self) { num in
                    Image(systemName: num <= rating.amountOfStars ? "star.fill" : "star")
                }
            }.foregroundColor(.black)
           
            Text("\(rating.ratingHeadline)")
                .foregroundColor(.black)
                .padding(.leading, 10)
            
            Spacer()
            
                
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing, 5)
            
        }.padding()
        .frame(height: 35)
        .onTapGesture {
            moreDetails = true
        }
        .sheet(isPresented: $moreDetails, content: {
            CarRatingDetailView(car: car, rating: rating)
                .presentationDetents([.medium, .large])
        })
    }
}

#Preview {
    CarRatingCellView(car: PreviewData().loadCars()[0], rating: Rating(amountOfStars: 4, ratingHeadline: "Incredible", ratingDescription: "Great car"))
}
