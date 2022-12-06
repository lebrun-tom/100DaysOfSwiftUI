//
//  DetailedActivityView.swift
//  HabitTracking
//
//  Created by Tom LEBRUN on 10/10/2022.
//

import SwiftUI

struct DetailedActivityView: View {
    var id: UUID
    var name: String
    var description: String
    var counter: Int
    
    @ObservedObject var activities: Activities
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                    .font(.system(size: 40, weight: .bold))
                    .padding(.horizontal)
                                
                VStack {
                    Text("\(counter)")
                        .font(.system(size: 40, weight: .bold))
                    
                    Text("completed")
                }
                .padding(.horizontal)

            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Description :")
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                
                Text(description)
            }
            .padding()

            HStack {
                Button("Done! \(Image(systemName: "checkmark.square.fill"))") {
                    var updatedCounter = counter
                    updatedCounter += 1
                    
                    let currentActivity = Activity(id: id, name: name, description: description, counter: counter)
                                    
                    if let index = activities.items.firstIndex(of: currentActivity) {
                        activities.items[index].counter = updatedCounter
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .font(.title)
            .padding(.top)
            
            Spacer()
        }
        .padding(.top)
    }
}

struct DetailedActivityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedActivityView(id: UUID(), name: "Read", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.x Quisque malesuada sem sit amet auctor scelerisque. Phasellus in fermentum enim, ut pellentesque massa. Proin commodo scelerisque molestie.", counter: 0, activities: Activities())
    }
}
