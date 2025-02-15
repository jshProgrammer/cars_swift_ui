//
//  AddCarRatingViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class AddCarRatingViewModel : ObservableObject {
    
    let db: Firestore
    var car: Car
    
    init() {
        db = Firestore.firestore()
    }
    
    
    
    func transformCarNameForDB() -> String {
        // for instance: audi:a6e-tron
        return "\(car.brand.lowercased()):\(car.model.replacingOccurrences(of: " ", with: "").lowercased())"
    }
}
