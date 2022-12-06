//
//  ContentView.swift
//  RememberFace
//
//  Created by Tom LEBRUN on 09/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var persons = [Person]()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(persons.sorted()) { person in
                        NavigationLink {
                            DetailView(person: person)
                        } label: {
                            HStack {
                                person.image?
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .padding(.trailing)
                                
                                Text(person.name)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
                .task {
                    await loadData()
                }
            }
            .navigationTitle("Remember face")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddPersonView(persons: $persons)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    func delete(at offsets: IndexSet) {
        persons.remove(atOffsets: offsets)
        
        let personsPath = FileManager.documentsDirectory.appendingPathComponent("personsData")
        
        do {
            let data = try JSONEncoder().encode(persons)
            try data.write(to: personsPath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func loadData() async {
        let personsPath = FileManager.documentsDirectory.appendingPathComponent("personsData")

        do {
            let personsData = try Data(contentsOf: personsPath)
            
            persons = try JSONDecoder().decode([Person].self, from: personsData)
            
        } catch {
            persons = []
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
