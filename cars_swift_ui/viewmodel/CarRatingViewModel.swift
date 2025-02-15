//
//  CarRatingViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import Foundation

class CarRatingViewModel: ObservableObject {
    var car: Car
    @Published var ratings: [Rating] = []
    
    init(car: Car) {
        self.car = car
        loadRatings()
    }
    
    func loadRatings() {
        ratings = [Rating(amountOfStars: 5, ratingHeadline: "Great car",  ratingDescription: "The 2025 Audi RS e-tron GT Performance stands as a testament to Audi's commitment to blending electrifying performance with luxury and cutting-edge technology.\nPerformance and Powertrain\nAt the heart of this electric grand tourer lies a formidable 912-horsepower setup, propelling the RS e-tron GT Performance from 0 to 60 mph in a mere 2.4 seconds.\n This remarkable acceleration is complemented by a 105 kWh battery pack, offering an estimated range of 300 miles on a single charge. The vehicle supports rapid 320 kW charging, enabling an 80% charge in just 18 minutes at compatible DC fast-charging stations.\nDriving Dynamics\n The RS e-tron GT Performance is not just about straight-line speed; it excels in handling and ride quality. Equipped with rear-axle steering and air suspension, the vehicle delivers a balanced and engaging driving experience. Reviewers have praised its capability to navigate challenging terrains with confidence, noting its adeptness on both dry and slippery surfaces.\nDesign and Interior\nAesthetically, the RS e-tron GT Performance embodies Audi's design philosophy with its sleek, aerodynamic silhouette and aggressive stance. Inside, the cabin offers a blend of luxury and technology, featuring high-quality materials and a driver-centric layout. The infotainment system is intuitive, providing seamless connectivity and access to various driving modes and settings.\nConclusion\nThe 2025 Audi RS e-tron GT Performance is a compelling choice for enthusiasts seeking an electric vehicle that doesn't compromise on performance, luxury, or technological innovation. Its combination of blistering acceleration, dynamic handling, and sophisticated design positions it as a standout in the high-performance electric vehicle segment."), Rating(amountOfStars: 4, ratingHeadline: "Nice", ratingDescription: "The 2025 Audi RS e-tron GT Performance stands as a testament to Audi's commitment to blending electrifying performance with luxury and cutting-edge technology.\nPerformance and Powertrain\nAt the heart of this electric grand tourer lies a formidable 912-horsepower setup, propelling the RS e-tron GT Performance from 0 to 60 mph in a mere 2.4 seconds.\n This remarkable acceleration is complemented by a 105 kWh battery pack, offering an estimated range of 300 miles on a single charge. The vehicle supports rapid 320 kW charging, enabling an 80% charge in just 18 minutes at compatible DC fast-charging stations.\nDriving Dynamics\n The RS e-tron GT Performance is not just about straight-line speed; it excels in handling and ride quality. Equipped with rear-axle steering and air suspension, the vehicle delivers a balanced and engaging driving experience. Reviewers have praised its capability to navigate challenging terrains with confidence, noting its adeptness on both dry and slippery surfaces.\nDesign and Interior\nAesthetically, the RS e-tron GT Performance embodies Audi's design philosophy with its sleek, aerodynamic silhouette and aggressive stance. Inside, the cabin offers a blend of luxury and technology, featuring high-quality materials and a driver-centric layout. The infotainment system is intuitive, providing seamless connectivity and access to various driving modes and settings.\nConclusion\nThe 2025 Audi RS e-tron GT Performance is a compelling choice for enthusiasts seeking an electric vehicle that doesn't compromise on performance, luxury, or technological innovation. Its combination of blistering acceleration, dynamic handling, and sophisticated design positions it as a standout in the high-performance electric vehicle segment.")]
    }
}
