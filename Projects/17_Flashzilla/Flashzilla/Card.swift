//
//  Card.swift
//  Flashzilla
//
//  Created by Tom LEBRUN on 20/11/2022.
//

import Foundation

struct Card: Codable, Hashable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
