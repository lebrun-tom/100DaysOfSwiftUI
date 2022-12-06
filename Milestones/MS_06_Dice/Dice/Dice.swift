//
//  Dice.swift
//  Dice
//
//  Created by Tom LEBRUN on 27/11/2022.
//

import Foundation

struct Dice: Identifiable, Codable {
    var id = UUID()
    var number: Int
    var date: Date
}
