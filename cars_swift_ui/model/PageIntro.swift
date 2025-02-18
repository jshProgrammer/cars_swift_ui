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
    var decisionSignUpOrLogIn: Bool = false
    var lastScreenLogIn: Bool = false
    var lastScreenSignUp: Bool = false
}

var pageIntros: [PageIntro] = [
    .init(introImage: "Login_01", title: "Store your favourites accross devices"),
    .init(introImage: "Login_02", title: "Log in to optimize your app for your needs", decisionSignUpOrLogIn: true),
    .init(introImage: "Login_03", title: "Sign up for great experience", lastScreenSignUp: true),
    .init(introImage: "Login_03", title: "Let's get started", lastScreenLogIn: true)
]
