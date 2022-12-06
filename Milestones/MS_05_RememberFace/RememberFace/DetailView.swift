//
//  DetailView.swift
//  RememberFace
//
//  Created by Tom LEBRUN on 09/11/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    var person: Person
        
    @State private var mapRegion =  MKCoordinateRegion()
    
    var hasLocation: Bool {
        if person.latitude == nil || person.longitude == nil {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack {
            person.image?
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.horizontal)
                
            
            if hasLocation {
                if let coordinate = person.coordinate {
                    VStack {
                        Map(coordinateRegion: $mapRegion, annotationItems: [person]) { _ in
                            MapMarker(coordinate: coordinate)
                        }
                    }
                    .onAppear() {
                        mapRegion.center = coordinate
                        mapRegion.span = MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)
                    }
                }
            }
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }


}
