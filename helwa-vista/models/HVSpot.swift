//
//  HVSpot.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 12.12.25.
//

import Foundation

struct HVSpot {
    let id: UUID = UUID()
    let title: String
    let image: String
    let description: String
    let coordinates: (latitude: Double, longitude: Double)
    
    static let sampleSpots: [HVSpot] = [
        HVSpot(title: "Golden Gate Bridge", image: "golden-gate-bridge.jpg", description: "A historic suspension bridge in San Francisco.", coordinates: (latitude: 37.8199, longitude: -122.4783)),
        HVSpot(title: "Statue of Liberty", image: "statue-of-liberty.jpg", description: "A colossal neoclassical statue in New York City.", coordinates: (latitude: 40.6892, longitude: -74.0445)),
        HVSpot(title: "Christ the Redeemer", image: "christ-the-redeemer.jpg", description: "A iconic statue in Rio de Janeiro, Brazil.", coordinates: (latitude: -22.9068, longitude: -43.1729))
    ]
}
