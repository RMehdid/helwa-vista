//
//  CLLocationCoordinate2D.swift
//  helwa-vista
//
//  Created by Mehdid, Samy Abderraouf on 09.12.25.
//

import Foundation
import CoreLocation

// MARK: - CLLocationCoordinate2D Extension
extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
