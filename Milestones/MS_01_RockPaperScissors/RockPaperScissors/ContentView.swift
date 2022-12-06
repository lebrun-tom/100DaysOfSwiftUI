//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Tom LEBRUN on 18/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    let choices = ["Rock", "Paper", "Scissors"]
    
    @State private var shouldWin: Bool = Bool.random()
    @State private var appChoice: Int = Int.random(in: 0..<3)
    
    @State private var score: Int = 0
    
    @State private var round: Int = 0
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color.mint
                .ignoresSafeArea()

            VStack {
                Text("You need to")
                    .font(.title2)
                Text(shouldWin ? "Win" : "Lose")
                    .padding(8)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .font(.title)
                
                Spacer()
                
                Text("Round \(round) / 10")
                    .font(.title2)
                
                Spacer()
                
                Image(choices[appChoice])
                    .renderingMode(.original)
                    .resizable()
                    .frame(maxWidth: 300, maxHeight: 300)
                
                Spacer()
                
                HStack {
                    ForEach(choices, id: \.self) { choice in
                        Spacer()
                        
                        Button {
                            ButtonTapped(userChoice: choice, shouldWin: shouldWin)
                        } label: {
                            Image(choice)
                                .renderingMode(.original)
                                .resizable()
                                .frame(maxWidth: 80, maxHeight: 80)
                        }
                        
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("Score : \(score)")
                    .font(.title2)

                
            }
            .alert("End of the game", isPresented: $showAlert){
                Button("Restart", action: resetGame)
            } message: {
                Text("Score : \(score) / 10")
            }
        }
    }
    
    func ButtonTapped(userChoice: String, shouldWin: Bool) {
        if userChoice == "Scissors" && choices[appChoice] == "Paper" {
            if shouldWin == true {
                score += 1
            } else {
                print("lose")
                score -= 1
            }
        }
        else if userChoice == "Rock" && choices[appChoice] == "Scissors" {
            if shouldWin == true {
                score += 1
            } else {
                score -= 1
            }        }
        else if userChoice == "Paper" && choices[appChoice] == "Rock" {
            if shouldWin == true {
                score += 1
            } else {
                score -= 1
            }        }
        else if userChoice == choices[appChoice] {
            print("no winner...")
        }
        else {
            if shouldWin == true {
                score -= 1
            } else {
                score += 1
            }
        }
        
        round += 1
        
        if round == 10 {
            showAlert = true
        } else {
            nextRound()
        }
    }
    
    func nextRound() {
        shouldWin.toggle()
        appChoice = Int.random(in: 0..<3)
    }
    
    func resetGame() {
        shouldWin.toggle()
        appChoice = Int.random(in: 0..<3)
        score = 0
        round = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
