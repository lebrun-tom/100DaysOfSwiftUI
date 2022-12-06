//
//  ContentView.swift
//  Dice
//
//  Created by Tom LEBRUN on 27/11/2022.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        VStack {
            TabView {
                RollView()
                    .tabItem {
                        Label("Roll Dice", systemImage: "dice")
                    }
                
                HistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.circlepath")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
