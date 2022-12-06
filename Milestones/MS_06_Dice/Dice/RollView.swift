//
//  RollView.swift
//  Dice
//
//  Created by Tom LEBRUN on 27/11/2022.
//

import SwiftUI

struct RollView: View {
    @State private var randomDice = Dice(number: 2, date: Date.now)
    @State private var rolledDice = [Dice]()
    @State private var randomValue = 2
    @State private var counter = 4
    @State private var isRolled = false

    @State private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @State private var feedback = UINotificationFeedbackGenerator()

    var body: some View {
        VStack {
            Spacer()
            Image("dice-\(randomValue)")
                .resizable()
                .frame(width: 100, height: 100)
                .onReceive(timer) { time in
                    feedback.prepare()
                    if counter >= 3 {
                        feedback.notificationOccurred(.success)
                        timer.upstream.connect().cancel()
                        
                        if isRolled {
                            randomDice.id = UUID()
                            randomDice.number = randomValue
                            randomDice.date = Date.now
                            
                            rolledDice.insert(randomDice, at: 0)
                            saveData()
                        }
                        
                    } else {
                        randomValue = Int.random(in: 1...6)
                    }
                    
                    counter += 1
                }
            
            Spacer()
            
            Button("Roll the dice") {
                
                
                counter = 0
                timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
                isRolled = true
            }
            .font(.title2)
            .padding(5)
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding()
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
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
