//
//  Person.swift
//  RememberFace
//
//  Created by Tom LEBRUN on 09/11/2022.
//

import Foundation
import SwiftUI
import MapKit

struct Person: Codable, Identifiable, Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    var id = UUID()
    var imageData: Data
    var name: String
    var latitude: Double? = nil
    var longitude: Double? = nil
    
    var image: Image? {
        let uiImage = UIImage(data: imageData)
        
        guard let uiImage = uiImage else { return nil }
        
        return Image(uiImage: uiImage)
    }
    
    var coordinate: CLLocationCoordinate2D? {
        var coord = CLLocationCoordinate2D()
        
        if let latitude = latitude {
            coord.latitude = latitude
        }
        
        if let longitude = longitude {
            coord.longitude = longitude
        }
        return coord
    }
    
    
}
