//
//  Prospect.swift
//  HotProspects
//
//  Created by Tom LEBRUN on 14/11/2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    var createdAt = Date()
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
 
    let savePath = FileManager.documentsDirectory.appendingPathExtension("SavedPersons")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            self.people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            self.people = []
        }
        
    }
    
    private func save(){
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
