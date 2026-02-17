//
//  HVTrip.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 12.12.25.
//

import Foundation

struct HVTrip {
    let id: UUID = UUID()
    let image: String
    let location: String
    let period: Int
    let coordinates: (latitude: Double, longitude: Double)
    let spots: [HVSpot]
    
    static var sampleTrip = HVTrip(
        image: "Budapest",
        location: "Budapest",
        period: 3,
        coordinates: (latitude: 36.8969, longitude: 10.1819),
        spots: HVSpot.sampleSpots
        )
    
    var durationTitle: String {
        return "\(period)-Day \(location) Trip"
    }
    
    var daysTitle: String {
        return "\(period) Days"
    }
    
    var nightsTitle: String {
        return "\(period - 1) Nights"
    }
    
    var spotsTitle: String {
        return "\(spots.count) Spots"
    }
}
