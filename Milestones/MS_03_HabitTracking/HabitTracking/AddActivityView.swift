//
//  AddActivityView.swift
//  HabitTracking
//
//  Created by Tom LEBRUN on 10/10/2022.
//

import SwiftUI

struct AddActivityView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    
    @ObservedObject var activities: Activities

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Title of the activity", text: $name)
            } header: {
                Text("Title")
            }
            
            Section {
                TextField("Description of the activity", text: $description)
            } header: {
                Text("Description")
            }
            
            Button("Save activity") {
                let activity = Activity(name: name, description: description)
                activities.items.append(activity)
                dismiss()
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
