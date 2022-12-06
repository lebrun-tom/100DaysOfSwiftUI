//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Tom LEBRUN on 28/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State private var questionNumber = 1
    @State private var score = 0
    @State private var order = Bool.random()
    
    @State private var table = 2
    @State private var numberOfQuestions = 5
    @State private var userResponse = 0
    
    @State private var titleAlert = ""
    @State private var messageAlert = ""
    @State private var showAlert = false
    
    @State private var showReturnToHomeAlert = false
    
    @State private var randomNumber = Int.random(in: 2..<12)
    @State private var secondRandomNumber = Int.random(in: 2..<7)
    
    var trueNumber: Int {
        return randomNumber * table
    }
    
    var falseNumber: Int {
        return randomNumber * table - secondRandomNumber
    }
    
    let possibleNumberOfQuestions = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            VStack {
                //Screen of configurations
                if !isActive {
                    Spacer()
                                        
                    VStack {
                        Text("Choose a Times Table :")
                            .font(.title2)
                        ForEach(0..<3) { row in
                            HStack {
                                ForEach(2..<6) { column in
                                    Button {
                                        table = column + row * 4
                                    } label: {
                                        VStack {
                                            Image("\(column + row * 4)")
                                                .renderingMode(.original)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(maxWidth: 85, maxHeight: 85)
                                            
                                            Text("\(column + row * 4)")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Section {
                        Picker("How many questions ?", selection: $numberOfQuestions) {
                            ForEach(possibleNumberOfQuestions, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("How many questions would you like ?")
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        isActive = true
                    } label: {
                        Text("Start the \(table) times table")
                    }
                    .padding(10)
                    .background(.indigo)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                //Screen of questions
                else {
                    Text("Question \(questionNumber) of \(numberOfQuestions)")
                        .padding()
                        .bold()
                    
                    Image("\(table)")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: 85, maxHeight: 85)
                    
                    Spacer()
                    
                    Text("What is \(table) x \(randomNumber) ?")
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        if order {
                            Button("\(trueNumber)") {
                                checkAnswer(userResponse: trueNumber)
                            }
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(.indigo)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Button("\(falseNumber)") {
                                checkAnswer(userResponse: falseNumber)
                            }
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(.indigo)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        } else {
                            Button("\(falseNumber)") {
                                checkAnswer(userResponse: falseNumber)
                            }
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(.indigo)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Button("\(trueNumber)") {
                                checkAnswer(userResponse: trueNumber)
                            }
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(.indigo)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                    
                    Spacer()
                    Spacer()
                }
            }
            .padding()
            .navigationTitle("Times Table")
            .alert("Finished!", isPresented: $showReturnToHomeAlert) {
                Button("Return to home", action: resetGame)
            } message: {
                Text("Your score is : \(score) / \(numberOfQuestions)")
            }
            .alert(titleAlert, isPresented: $showAlert) {
                Button("OK", action: nextQuestion)
            } message: {
                Text("\(messageAlert)")
            }
            
        }
    }
    
    func checkAnswer(userResponse: Int) {
        let correctAnswer = table * randomNumber
    
            if userResponse == correctAnswer {
                titleAlert = "Correct!"
                messageAlert = ""
                score += 1
            } else {
                titleAlert = "Wrong!"
                messageAlert = "\(table) x \(randomNumber) = \(correctAnswer)"
            }

        if questionNumber == numberOfQuestions {
            showReturnToHomeAlert = true
        }
        
        showAlert = true
    }
    
    func nextQuestion() {
        randomNumber = Int.random(in: 2..<12)
        userResponse = 0
        questionNumber += 1
        order = Bool.random()
    }
    
    func resetGame() {
        isActive = false
        userResponse = 0
        questionNumber = 1
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
