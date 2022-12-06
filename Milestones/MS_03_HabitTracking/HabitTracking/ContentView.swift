//
//  ContentView.swift
//  HabitTracking
//
//  Created by Tom LEBRUN on 10/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheetForAddingActivity = false
    
    @StateObject var activities = Activities()

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(activities.items) { activity in
                        NavigationLink{
                            DetailedActivityView(id: activity.id, name: activity.name, description: activity.description, counter: activity.counter, activities: activities)
                        } label: {
                            Text(activity.name)
                        }
                    }
                    .onDelete(perform: deleteItem)
                    
                    if activities.items.count == 0 {
                        Text("No activities recorded yet...")
                            .foregroundColor(.gray)
                    }
                } header: {
                    Text("List of my activities")
                }
            }
            .navigationTitle("Habit Tracking")
            .toolbar {
                Button {
                    showingSheetForAddingActivity.toggle()
                } label: {
                    Text(Image(systemName: "plus"))
                }
            }
            .sheet(isPresented: $showingSheetForAddingActivity) {
                AddActivityView(activities: activities)
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
