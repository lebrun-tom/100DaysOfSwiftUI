//
//  AddPersonView.swift
//  RememberFace
//
//  Created by Tom LEBRUN on 09/11/2022.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var name = ""
    
    @State private var saveLocation = false
    
    @State private var titleAlert = ""
    @State private var messageAlert = ""
    @State private var showAlert = false
    
    @Binding var persons: [Person]
    
    let locationFetcher = LocationFetcher()
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    
    var body: some View {
        VStack {
            Form {
                Section {
                    if inputImage == nil {
                        Button("Add picture") {
                            showingImagePicker = true
                        }
                    } else {
                        Image(uiImage: inputImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 400)
                            .onTapGesture {
                                showingImagePicker = true
                            }
                    }

                    TextField("Name", text: $name)
                }
                
                Toggle(isOn: $saveLocation) {
                    Text("Save location")
                }
                .onChange(of: saveLocation) { location in
                    self.locationFetcher.start()
                }
                
                Button("Save") {
                    save()
                }
            }
            .alert(titleAlert, isPresented: $showAlert) {
                Text(messageAlert)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func save() {
        let personsPath = FileManager.documentsDirectory.appendingPathComponent("personsData")
        
        guard let jpegData = inputImage?.jpegData(compressionQuality: 0.8) else { return }

        var person = Person(id: UUID(), imageData: jpegData, name: name)

        if let location = self.locationFetcher.lastKnownLocation {
            person.latitude = location.latitude
            person.longitude = location.longitude
        } else {
            print("Your location is unknown")
        }
        
        persons.append(person)
                
        do {
            let data = try JSONEncoder().encode(persons)
            try data.write(to: personsPath, options: [.atomic, .completeFileProtection])
            presentationMode.wrappedValue.dismiss()
        } catch {
            titleAlert = "Error"
            messageAlert = "Unable to save data."
            showAlert = true
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(persons: .constant([Person]()))
    }
}
