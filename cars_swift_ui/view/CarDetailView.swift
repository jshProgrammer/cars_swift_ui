//
//  CarDetailView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 08.02.25.
//

import SwiftUI

struct CarDetailView : View {
    var car: Car
    
    var body: some View {
            
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                AsyncImage(url: car.image) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                        .overlay(
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .shadow(radius: 10)
                        .padding()
                    
                } placeholder: {
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                        ProgressView()
                    } .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        .foregroundColor(.none)
                }
                
                Text("\(car.brand) \(car.model)")
                    .font(.title)
                
                VStack(alignment: .leading) {
                    
                    CarDetailRow(car: car, imageName: "dollarsign",upperText: "starting from", lowerText: "\(car.convertPriceToString())")
                    
                    CarDetailRow(car: car, imageName: "calendar" ,upperText: "year", lowerText: "\(car.year)")
                    
                    CarDetailRow(car: car, imageName: "fuelpump" ,upperText: "fuel type", lowerText: "\(car.fuelType)")
                    
                    CarDetailRow(car: car, imageName: "gauge.with.dots.needle.67percent" ,upperText: "horsepower", lowerText: "\(car.horsepower)")
                    
                    CarDetailRow(car: car, imageName: "car" ,upperText: "car type", lowerText: "\(car.horsepower)")
                    
                    CarDetailRow(car: car, imageName: "gearshift.layout.sixspeed" ,upperText: "transmission", lowerText: "\(car.transmission)")
                    
                }
                
                Divider()
                
                Text("User ratings")
                    .font(.title2)
                
                Text("Add user ratings here in the future")
            }.padding()
            
        }
    }
}

struct CarDetailRow: View {
    var car: Car
    var imageName: String
    
    var upperText: String
    var lowerText: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 25, height: 25)
            
            VStack(alignment: .leading) {
                
                Text("\(upperText)")
                    .font(.caption)
                
                Text("\(lowerText)")
                    .font(.title3)
                
            }
        }.padding(.vertical, 4)
    }
}

#Preview {
    CarDetailView(car: PreviewData().loadCars()[0])
}
