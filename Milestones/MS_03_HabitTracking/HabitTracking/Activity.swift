//
//  Activity.swift
//  HabitTracking
//
//  Created by Tom LEBRUN on 10/10/2022.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var counter: Int = 0
}
