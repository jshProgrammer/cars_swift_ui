//
//  CarCellView.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 09.02.25.
//

import SwiftUI

struct CarCellView: View {
    var car: Car;
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: car.image) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
            } placeholder: {
                ProgressView()
            }
            
            VStack {
                
                Text("\(car.brand) \(car.model)")
                    .font(.headline)
                
                Text("starting from \(car.price)€")
                    .font(.subheadline)
                
            }
        }
    }
}

#Preview {
    CarCellView(car: PreviewData().loadCars()[0])
}
