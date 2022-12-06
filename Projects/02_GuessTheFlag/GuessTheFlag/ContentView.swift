//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tom LEBRUN on 13/09/2022.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct FlagImage: View {
    var countrie: String
    
    var body: some View {
        Image(countrie)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
    
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var userScore: Int = 0
    @State private var showingResult = false
    
    @State private var numberOfQuestion: Int = 1
    
    @State private var animationAmount = 0.0
    @State private var buttonTapped = 0
    @State private var opacityAmount = 1.0
    
    @State private var colorAnswer = Color.white.opacity(0)
    
    let maxScore: Int = 8
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 600)
                .ignoresSafeArea()
                            
            VStack {
                Spacer()

                Text("Guess the Flag")
                    .titleStyle()

                Spacer()

                Text("Question \(numberOfQuestion)")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            buttonTapped = number
                            flagTapped(number)
                            withAnimation {
                                animationAmount += 360
                                opacityAmount = 0.25
                            }
                            
                        } label: {
                            FlagImage(countrie: countries[number])
                                .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        }
                        .rotation3DEffect(Angle(degrees: buttonTapped == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(buttonTapped != number ? opacityAmount : 1)
                        .overlay {
                            Capsule()
                                .stroke(buttonTapped == number ? colorAnswer : Color.white.opacity(0), lineWidth: 4)
                        }
                    
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)/\(maxScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)/\(maxScore)")
        }
        .alert("End of the game", isPresented: $showingResult){
            Button("Restart", action: reset)
        } message: {
            Text("Your score is \(userScore)/\(maxScore)")
        }

    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            withAnimation {
                colorAnswer = .green
            }
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            withAnimation {
                colorAnswer = .red
            }
        }

        showingScore = true
        
        if numberOfQuestion == 8 {
            showingResult = true
        }
        
        numberOfQuestion += 1
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        withAnimation {
            animationAmount = 0.0
            opacityAmount = 1.0
            colorAnswer = Color.white.opacity(0)
        }
    }
    
    func reset() {
        userScore = 0
        numberOfQuestion = 1
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
