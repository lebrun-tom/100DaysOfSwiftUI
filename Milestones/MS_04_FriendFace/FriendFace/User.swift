//
//  User.swift
//  FriendFace
//
//  Created by Tom LEBRUN on 23/10/2022.
//

import Foundation

struct User: Codable {
    let id: String
    let isActive: Bool
    let company: String
    let name: String
    let age: Int
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    
    let friends: [Friend]
}
