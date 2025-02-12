//
//  PageIntro.swift
//  cars_swift_ui
//
//  Created by Joshua Pfennig on 12.02.25.
//

import Foundation

struct PageIntro: Identifiable, Hashable {
    var id: UUID = .init()
    var introImage: String
    var title: String
    var lastScreen: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introImage: "Login_01", title: "Store your favourites accross devices"),
    .init(introImage: "Login_02", title: "Log in to optimize your app for your needs"),
    .init(introImage: "Login_03", title: "Let's get started", lastScreen: true)
]
