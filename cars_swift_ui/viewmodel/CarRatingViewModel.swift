//
//  CarRatingViewModel.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 15.02.25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore



class CarRatingViewModel: ObservableObject {
    var car: Car
    @Published var ratings: [Rating] = []
    let db: Firestore
    
    init(car: Car) {
        self.car = car

        db = Firestore.firestore()
        
        Task {
            await loadRatings()
        }
    }
    
    func loadRatings() async {
        do {
            let snapshot = try await db.collection("ratings/userRatings/\(transformCarNameForDB())").getDocuments()
            if snapshot.isEmpty {
                print("No documents found.")
            } else {
                for document in snapshot.documents {
                    print("Document found: \(document.documentID) => \(document.data())")
                    DispatchQueue.main.async {
                        self.ratings.append(self.transformDocumentToRating("\(document.data())"))
                    }
                }
            }
        
        } catch {
            DispatchQueue.main.async {
                print("Error getting documents: \(error)")
            }
        }
    }
    
    func transformCarNameForDB() -> String {
        // for instance: audi:a6e-tron
        return "\(car.brand.lowercased()):\(car.model.replacingOccurrences(of: " ", with: "").lowercased())"
    }
    
    // doc for instance: ["ratingDescription": Great, "amountOfStars": 4, "ratingHeadline": Incredible]
    func transformDocumentToRating(_ input: String) -> Rating {
        let trimmed = input
            .replacingOccurrences(of: "^\\[|\\]$", with: "", options: .regularExpression)
        
        let pattern = #""(\w+)":\s((?:\\"|.)*?)(?=,\s"|$)"#
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators) else {
            return errorRating()
        }
        
        var result = [String: String]()
        let nsString = trimmed as NSString
        let matches = regex.matches(
            in: trimmed,
            range: NSRange(location: 0, length: trimmed.utf16.count)
        )
        
        for match in matches {
            guard match.numberOfRanges >= 2,
                  let key = nsString.substring(with: match.range(at: 1)) as String?,
                  let value = nsString.substring(with: match.range(at: 2)) as String? else {
                continue
            }
            
            result[key] = value
                .replacingOccurrences(of: "\\n", with: "\n")
                .replacingOccurrences(of: "\\\"", with: "\"")
                .trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        guard let stars = result["amountOfStars"].flatMap(Int.init) else {
            return errorRating()
        }
        
        return Rating(
            amountOfStars: stars,
            ratingHeadline: result["ratingHeadline"] ?? "",
            ratingDescription: result["ratingDescription"] ?? ""
        )
    }



    private func errorRating() -> Rating {
        return Rating(
            amountOfStars: 0,
            ratingHeadline: "Parsing error",
            ratingDescription: "Invalid rating format"
        )
    }


   

}
