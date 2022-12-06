//
//  HistoryView.swift
//  Dice
//
//  Created by Tom LEBRUN on 27/11/2022.
//

import SwiftUI

struct HistoryView: View {
    @State private var rolledDice = [Dice]()

    var body: some View {
        List {
            ForEach(rolledDice) { item in
                VStack(alignment: .leading) {
                    Text("Value : \(item.number)")
                        .foregroundColor(.primary)
                    Text("\(item.date.formatted(.dateTime))")
                        .foregroundColor(.secondary)
                }
            }
            .onDelete(perform: delete)
        }
        .onAppear(perform: loadData)
    }
              
    func saveData(){
        let savePath = FileManager.documentsDirectory.appendingPathComponent("rolledDice")

        do {
            let data = try JSONEncoder().encode(rolledDice)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error : \(error.localizedDescription)")
        }
    }
    
    func loadData(){
        let savePath = FileManager.documentsDirectory.appendingPathComponent("rolledDice")

        do {
            let data = try Data(contentsOf: savePath)
            rolledDice = try JSONDecoder().decode([Dice].self, from: data)
        } catch {
            rolledDice = [Dice]()
        }
    }
    
    func delete(at offsets: IndexSet){
        rolledDice.remove(atOffsets: offsets)
        saveData()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
