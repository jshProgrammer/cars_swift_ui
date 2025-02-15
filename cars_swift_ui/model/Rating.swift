//
//  Rating.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import Foundation
import SwiftData

//@Model
class Rating: Hashable {
    @Attribute(.unique) var id: UUID = UUID()
    var amountOfStars: Int
    var ratingHeadline: String
    var ratingDescription: String
 
    required init(amountOfStars: Int, ratingHeadline: String, ratingDescription: String) {
        self.amountOfStars = amountOfStars
        self.ratingHeadline = ratingHeadline
        self.ratingDescription = ratingDescription
    }
    
    static func == (lhs: Rating, rhs: Rating) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
   }
}
