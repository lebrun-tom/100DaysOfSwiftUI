//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Tom LEBRUN on 16/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .background(.red)
                .foregroundColor(.white)


        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
