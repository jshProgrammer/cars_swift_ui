//
//  AddCarRatingView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import SwiftUI

struct AddCarRatingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var carRatingViewModel: CarRatingViewModel
    
    var car: Car
    @State var amountOfStars: Int = 1
    @State var headline: String = ""
    @State var description: String = ""
    
    init(car: Car) {
        self.car = car
        self._carRatingViewModel = StateObject(wrappedValue: CarRatingViewModel(car: car))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ForEach(1...5, id: \.self) { num in
                        Button {
                            amountOfStars = num
                        } label: {
                            Image(systemName: num <= amountOfStars ? "star.fill" : "star")
                        }
                    }
                }.foregroundColor(.black)
                    .padding(.vertical, 15)

                
                
                TextField("Heading", text: $headline)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 15)
            
                
                ZStack(alignment: .topLeading) {
                    //TODO: is not shown
                    if description == "" {
                        Text("Description")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 12)
                    }
                    
                    TextEditor(text: $description)
                        .padding(.horizontal, 4)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .cornerRadius(5)
                }
                
            }
            .padding()
            .navigationTitle("Add rating for \(car.brand) \(car.model)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        //TODO: ensure that CarDetailView is updated immediately and ensure that alert is presented (un-/successful)
                        //TODO: should only work if logged in
                        Task {
                            await carRatingViewModel.addRating(rating: Rating(amountOfStars: amountOfStars, ratingHeadline: headline, ratingDescription: description))
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddCarRatingView(car: PreviewData().loadCars()[0])
}
